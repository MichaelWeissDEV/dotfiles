import importlib.util
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

HERE = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("component_check", HERE / "check-component.py")
component = importlib.util.module_from_spec(spec)
spec.loader.exec_module(component)


class ComponentTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.origin = self.root / "foot-config"
        (self.origin / "packaging/arch").mkdir(parents=True)
        self.recipe = self.origin / "packaging/arch/PKGBUILD"
        self.recipe.write_text("pkgname=arch-dotfiles-foot\ndepends=('arch-dotfiles-core>=0.3.0' 'foot')\n")
        (self.origin / "foot.ini").write_text("[main]\nfont=monospace\n")
        (self.root / "LICENSE").write_text("MIT")
        packages = self.root / "packages"
        (packages / "arch-dotfiles-core").mkdir(parents=True)
        (packages / "arch-dotfiles-core/BUNDLE-LICENSE").write_text("MIT")
        for name, value in (("ROOT", self.root), ("PACKAGES", packages), ("SOURCE_ROOT", self.root)):
            context = patch.object(component.source, name, value)
            context.start()
            self.addCleanup(context.stop)
        context = patch.object(component.source, "tracked_files", return_value={"foot.ini", "escape"})
        context.start()
        self.addCleanup(context.stop)

    def test_valid_component_contract(self):
        component.check("foot")

    def test_component_cannot_add_root_install_scriptlet(self):
        self.recipe.write_text(self.recipe.read_text() + "install=unsafe.install\n")
        with self.assertRaisesRegex(RuntimeError, "install scriptlet"):
            component.check("foot")

    def test_core_version_dependency_is_mandatory(self):
        self.recipe.write_text("pkgname=arch-dotfiles-foot\ndepends=('foot')\n")
        with self.assertRaisesRegex(RuntimeError, "core dependency"):
            component.check("foot")

    def test_missing_runtime_entrypoint_is_rejected(self):
        (self.origin / "foot.ini").unlink()
        with self.assertRaisesRegex(RuntimeError, "runtime entrypoint"):
            component.check("foot")

    def test_absolute_symlink_cannot_escape_payload(self):
        (self.origin / "escape").symlink_to("/etc/passwd")
        with self.assertRaisesRegex(RuntimeError, "absolute symlink"):
            component.check("foot")

    def test_relative_symlink_cannot_escape_payload(self):
        (self.origin / "escape").symlink_to("../../../../../../outside")
        with self.assertRaisesRegex(RuntimeError, "escapes"):
            component.check("foot")

    def test_jsonc_preserves_comment_markers_and_commas_in_strings(self):
        text = '{/* comment */ "url":"https://example.invalid/a//b", "text":",}", "list":[1,2,], // tail\n}'
        self.assertEqual(component.jsonc(text), {"url": "https://example.invalid/a//b", "text": ",}", "list": [1, 2]})

    def test_invalid_and_duplicate_jsonc_is_rejected(self):
        for text in ('{"a":1,"a":2}', '{/* unterminated', '{"a": ]}'):
            with self.subTest(text=text), self.assertRaises(ValueError):
                component.jsonc(text)
