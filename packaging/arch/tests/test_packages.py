import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[3]
spec = importlib.util.spec_from_file_location("prepare_source", ROOT / "packaging/arch/prepare-source.py")
source = importlib.util.module_from_spec(spec)
spec.loader.exec_module(source)


class PackageLayoutTest(unittest.TestCase):
    def test_versioning_rejects_shallow_history(self):
        with patch.object(source.subprocess, "check_output", return_value="true\n"):
            with self.assertRaisesRegex(RuntimeError, "Full Git history"):
                source.revision(ROOT)

    def test_each_package_has_independent_recipe_and_correct_dependencies(self):
        for name, data in source.REGISTRY.items():
            with self.subTest(package=name):
                recipe = source.package_recipe(name)
                self.assertTrue(recipe.is_file())
                result = subprocess.check_output([
                    "bash", "-c",
                    'source "$1"; printf "%s\\n" "$pkgname" "${depends[@]}"',
                    "bash", str(recipe),
                ], text=True).splitlines()
                self.assertEqual(result[0], name)
                self.assertEqual(result[1:], source.metadata(name)["depends"])
                if "module" in data:
                    self.assertTrue((source.component_root(data["module"]) / ".git").exists())
                    self.assertFalse((ROOT / "packages" / name).exists())
                    self.assertFalse((ROOT / data["module"]).exists())

    def test_internal_dependency_graph_has_no_cycles(self):
        visited = set()
        def visit(name, pending):
            self.assertNotIn(name, pending, f"Dependency cycle: {pending} -> {name}")
            if name in visited:
                return
            for dependency in source.metadata(name)["depends"]:
                dependency = dependency.split(">=")[0]
                if dependency.startswith("arch-dotfiles"):
                    self.assertIn(dependency, source.REGISTRY)
                    visit(dependency, pending | {name})
            visited.add(name)
        for name in source.REGISTRY:
            visit(name, set())

    def test_vim_payload_does_not_include_other_module_sources(self):
        with tempfile.TemporaryDirectory() as temporary:
            target = Path(temporary)
            source.stage("arch-dotfiles-vim", target)
            share = target / "usr/share/arch-dotfiles"
            self.assertTrue((share / "vim/vimrc").is_file())
            self.assertEqual(sorted(p.name for p in share.iterdir()), ["modules.d", "vim"])
            self.assertEqual((share / "modules.d/vim").read_text(), "vim\n")

    def test_private_and_untracked_files_are_never_exported(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            package = root / "hypr-config"
            package.mkdir(parents=True)
            core = root / "packages/arch-dotfiles-core"
            core.mkdir(parents=True)
            (root / "LICENSE").write_text("license")
            (core / "BUNDLE-LICENSE").write_text("license")
            for name in ("hyprland.lua", "monitors.local.lua", "secret", "screenshot.sh", "screenshot.desktop"):
                (package / name).write_text("fixture")
            destination = root / "export"
            tracked = {"hyprland.lua", "monitors.local.lua", "screenshot.sh", "screenshot.desktop"}
            with patch.object(source, "ROOT", root), patch.object(source, "PACKAGES", root / "packages"), patch.object(source, "SOURCE_ROOT", root):
                source.stage("arch-dotfiles-hypr", destination, tracked)
            share = destination / "usr/share/arch-dotfiles/hypr"
            self.assertTrue((share / "hyprland.lua").exists())
            self.assertFalse((share / "secret").exists())
            self.assertFalse((share / "monitors.local.lua").exists())


if __name__ == "__main__":
    unittest.main()
