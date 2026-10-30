from pathlib import Path
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[3]


class InstallerTest(unittest.TestCase):
    def run_installer(self, *arguments):
        return subprocess.run(["bash", str(ROOT / "install.sh"), *arguments], text=True, capture_output=True)

    def test_help_does_not_install(self):
        result = self.run_installer("--help")
        self.assertEqual(result.returncode, 0)
        self.assertIn("normal user", result.stdout)

    def test_dry_run_uses_only_selected_packages(self):
        result = self.run_installer("--dry-run", "nvim", "tmux")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("pacman -Syu --needed arch-dotfiles-nvim arch-dotfiles-tmux", result.stdout)
        self.assertIn("Signing fingerprint:", result.stdout)
        self.assertNotIn("arch-dotfiles-hypr", result.stdout)

    def test_default_is_complete_metapackage(self):
        result = self.run_installer("--dry-run")
        self.assertEqual(result.returncode, 0)
        self.assertIn("pacman -Syu --needed arch-dotfiles\n", result.stdout)

    def test_shell_metacharacters_and_unknown_flags_are_rejected(self):
        for argument in ("nvim;exit", "--unknown", "../nvim"):
            self.assertEqual(self.run_installer("--dry-run", argument).returncode, 2)
