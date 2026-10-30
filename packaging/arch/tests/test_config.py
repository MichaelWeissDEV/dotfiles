"""Lifecycle tests use temporary homes only; never touch the invoking user's config."""
import contextlib
import importlib.machinery
import importlib.util
import io
import json
import os
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch


SCRIPT = Path(__file__).resolve().parents[3] / "packages/arch-dotfiles-core/arch-dotfiles-config"
loader = importlib.machinery.SourceFileLoader("package_config", str(SCRIPT))
spec = importlib.util.spec_from_loader(loader.name, loader)
module = importlib.util.module_from_spec(spec)
loader.exec_module(module)


class ConfigTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.home = self.root / "home with spaces"
        self.home.mkdir()
        self.defaults = self.root / "defaults"
        self.defaults.mkdir()
        names = ["hypr", "tmux", "vim", "zsh", "wallpaper"]
        (self.defaults / "MODULES").write_text("\n".join(names) + "\n")
        for name in names:
            (self.defaults / name).mkdir()
            (self.defaults / name / "example").write_text("original")
        self.environment = patch.dict(os.environ, {
            "HOME": str(self.home), "XDG_CONFIG_HOME": str(self.home / ".config"),
            "XDG_DATA_HOME": str(self.home / ".local/share"),
            "XDG_STATE_HOME": str(self.home / ".local/state"),
        })
        self.environment.start()
        self.addCleanup(self.environment.stop)
        self.output = contextlib.redirect_stdout(io.StringIO())
        self.output.__enter__()
        self.addCleanup(self.output.__exit__, None, None, None)
        self.config = module.Config(self.defaults, self.home)
        self.config.state.mkdir(parents=True)

    def original_directory(self):
        target = self.home / ".config/hypr"
        target.mkdir(parents=True)
        (target / "before").write_text("personal previous settings")
        return target

    def test_activate_deactivate_restores_directory(self):
        target = self.original_directory()
        self.config.activate()
        self.assertTrue(target.is_symlink())
        self.config.deactivate()
        self.assertFalse(target.is_symlink())
        self.assertEqual((target / "before").read_text(), "personal previous settings")
        self.assertFalse(self.config.activation.exists())

    def test_dangling_symlink_is_backed_up_and_restored(self):
        target = self.home / ".zshrc"
        target.symlink_to("old-missing-zshrc")
        self.config.activate()
        self.config.deactivate()
        self.assertEqual(os.readlink(target), "old-missing-zshrc")

    def test_activation_is_idempotent(self):
        self.config.activate()
        first = self.config.activation.read_bytes()
        self.config.activate()
        self.assertEqual(self.config.activation.read_bytes(), first)

    def test_monitor_override_is_migrated_and_retained(self):
        target = self.original_directory()
        (target / "monitors.local.lua").write_text("my machine, not packaged")
        self.config.activate()
        migrated = self.config.work / "hypr/monitors.local.lua"
        self.assertEqual(migrated.read_text(), "my machine, not packaged")
        self.config.deactivate()
        self.assertEqual(migrated.read_text(), "my machine, not packaged")
        self.assertEqual((target / "monitors.local.lua").read_text(), migrated.read_text())

    def test_personal_workspace_edits_survive_deactivation(self):
        self.config.activate()
        edited = self.config.work / "hypr/example"
        edited.write_text("personal edit")
        self.config.deactivate()
        self.assertEqual(edited.read_text(), "personal edit")

    def test_update_replaces_only_unchanged_defaults(self):
        self.config.update()
        (self.defaults / "hypr/example").write_text("updated")
        self.config.update()
        self.assertEqual((self.config.work / "hypr/example").read_text(), "updated")

    def test_update_preserves_personal_edits_with_pacnew(self):
        self.config.update()
        edited = self.config.work / "hypr/example"
        edited.write_text("personal")
        (self.defaults / "hypr/example").write_text("updated")
        self.config.update()
        self.assertEqual(edited.read_text(), "personal")
        self.assertEqual(edited.with_suffix(".pacnew").read_text(), "updated")

    def test_existing_pacnew_is_not_overwritten(self):
        self.config.update()
        edited = self.config.work / "hypr/example"
        edited.write_text("personal")
        edited.with_suffix(".pacnew").write_text("my previous merge")
        (self.defaults / "hypr/example").write_text("updated")
        self.config.update()
        self.assertEqual(edited.with_suffix(".pacnew").read_text(), "my previous merge")
        self.assertEqual(edited.with_suffix(".pacnew.1").read_text(), "updated")

    def test_deleted_default_is_removed_only_if_unchanged(self):
        self.config.update()
        (self.config.work / "hypr/example").write_text("personal")
        (self.defaults / "hypr/example").unlink()
        (self.defaults / "tmux/example").unlink()
        self.config.update()
        self.assertEqual((self.config.work / "hypr/example").read_text(), "personal")
        self.assertFalse((self.config.work / "tmux/example").exists())

    def test_symlinked_file_never_modifies_its_target(self):
        self.config.update()
        external = self.root / "external"
        external.write_text("external")
        destination = self.config.work / "hypr/example"
        destination.unlink()
        destination.symlink_to(external)
        (self.defaults / "hypr/example").write_text("updated")
        self.config.update()
        self.assertEqual(external.read_text(), "external")
        self.assertTrue(destination.is_symlink())

    def test_update_refuses_directory_symlink(self):
        self.config.update()
        directory = self.config.work / "hypr"
        saved = self.root / "external-directory"
        directory.rename(saved)
        directory.symlink_to(saved, target_is_directory=True)
        with self.assertRaisesRegex(RuntimeError, "directory symlink"):
            self.config.update()

    def test_changed_activation_path_does_not_overwrite_user_data(self):
        target = self.original_directory()
        self.config.activate()
        target.unlink()
        target.mkdir()
        (target / "new-personal").write_text("keep")
        with self.assertRaisesRegex(RuntimeError, "changed after activation"):
            self.config.deactivate()
        self.assertEqual((target / "new-personal").read_text(), "keep")
        self.assertTrue(self.config.activation.exists())
        target.rename(target.with_name("hypr-new-personal"))
        self.config.deactivate()
        self.assertTrue((target / "before").is_file())

    def test_interrupted_activation_journal_recovers_original(self):
        target = self.original_directory()
        backup = self.config.state / "original"
        entry = {"path": str(target), "target": str(self.config.work / "hypr"), "backup": str(backup)}
        module.save_json(self.config.activation, [entry])
        target.rename(backup)
        self.config.deactivate()
        self.assertTrue((target / "before").is_file())

    def test_empty_interrupted_activation_is_not_already_active(self):
        module.save_json(self.config.activation, [])
        with self.assertRaisesRegex(RuntimeError, "incomplete"):
            self.config.activate()
        self.config.deactivate()

    def test_deactivation_does_not_need_installed_defaults(self):
        self.config.activate()
        self.config.defaults = self.root / "removed-package"
        self.config.deactivate()
        self.assertFalse(self.config.activation.exists())

    def test_custom_xdg_data_and_state_are_supported(self):
        with patch.dict(os.environ, {"XDG_DATA_HOME": str(self.root / "data"),
                                     "XDG_STATE_HOME": str(self.root / "state")}):
            config = module.Config(self.defaults, self.home)
            self.assertEqual(config.work, self.root / "data/arch-dotfiles/config")
            self.assertEqual(config.state, self.root / "state/arch-dotfiles")

    def test_custom_config_home_fails_explicitly(self):
        with patch.dict(os.environ, {"XDG_CONFIG_HOME": str(self.root / "unsupported")}):
            with self.assertRaisesRegex(RuntimeError, "XDG_CONFIG_HOME"):
                module.Config(self.defaults, self.home)

    def test_invalid_module_inventory_is_rejected(self):
        (self.defaults / "MODULES").write_text("../../unsafe\n")
        with self.assertRaisesRegex(RuntimeError, "inventory"):
            self.config.modules()

    def modular_inventory(self, names):
        (self.defaults / "MODULES").unlink(missing_ok=True)
        inventory = self.defaults / "modules.d"
        inventory.mkdir(exist_ok=True)
        for path in inventory.iterdir():
            path.unlink()
        for name in names:
            (inventory / name).write_text(name + "\n")

    def test_only_installed_modules_are_linked(self):
        self.modular_inventory(["vim"])
        self.config.activate()
        self.assertTrue((self.home / ".vimrc").is_symlink())
        self.assertFalse((self.home / ".zshrc").is_symlink())
        self.assertFalse((self.home / ".config/hypr").exists())
        self.assertFalse((self.home / ".local/bin/wallpaper").is_symlink())

    def test_new_package_can_be_activated_without_disturbing_existing(self):
        self.modular_inventory(["vim"])
        self.config.activate()
        original = json.loads(self.config.activation.read_text())[0]
        self.modular_inventory(["vim", "tmux"])
        self.config.activate()
        self.assertTrue((self.home / ".tmux.conf").is_symlink())
        self.assertEqual(json.loads(self.config.activation.read_text())[0], original)
        self.config.deactivate()
        self.assertFalse((self.home / ".vimrc").is_symlink())

    def test_selective_deactivation_preserves_other_modules(self):
        self.config.activate()
        self.config.selected = ["vim"]
        self.config.deactivate()
        self.assertFalse((self.home / ".vimrc").is_symlink())
        self.assertTrue((self.home / ".zshrc").is_symlink())
        self.assertTrue(self.config.activation.exists())

    def test_removed_package_keeps_user_copy(self):
        self.config.activate()
        self.modular_inventory(["vim"])
        self.config.update()
        self.assertEqual((self.config.work / "hypr/example").read_text(), "original")

    def test_selective_update_preserves_other_baselines(self):
        self.config.update()
        previous = json.loads(self.config.baseline.read_text())["hypr/example"]
        self.config.selected = ["vim"]
        self.config.update()
        self.assertEqual(json.loads(self.config.baseline.read_text())["hypr/example"], previous)

    def test_unchanged_defaults_are_not_recopied_by_timer(self):
        self.config.update()
        with patch.object(module.shutil, "copy2") as copy:
            self.config.update()
        copy.assert_not_called()

    def test_selective_update_does_not_traverse_inactive_modules(self):
        self.config.update()
        directory = self.config.work / "hypr"
        external = self.root / "external"
        directory.rename(external)
        directory.symlink_to(external, target_is_directory=True)
        self.config.selected = ["vim"]
        self.config.update()
        self.assertEqual((external / "example").read_text(), "original")

    def test_core_only_install_has_no_configuration_modules(self):
        (self.defaults / "MODULES").unlink()
        self.assertEqual(self.config.modules(), [])
        with self.assertRaisesRegex(RuntimeError, "No configuration packages"):
            self.config.activate()


if __name__ == "__main__":
    unittest.main()
