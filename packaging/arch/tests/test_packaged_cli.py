import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[3]


class PackagedCliTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        binary = self.root / "bin"
        binary.mkdir()
        self.log = self.root / "calls"
        for name, body in {
            "arch-dotfiles-config": 'printf "manager:%s\\n" "$*"',
            "sudo": 'printf "sudo:%s\\n" "$*"; exit "${PACMAN_FAILURE:-0}"',
            "git": "exit 99",
        }.items():
            script = binary / name
            script.write_text('#!/bin/bash\n' + body + '\n')
            script.chmod(0o755)
        self.env = dict(os.environ, HOME=str(self.root), PATH=str(binary) + os.pathsep + os.environ['PATH'])
        self.command = ["bash", str(ROOT / "packages/arch-dotfiles-core/adot")]

    def run_cli(self, *args):
        return subprocess.run([*self.command, *args], env=self.env, text=True, capture_output=True)

    def test_activate_selected_modules(self):
        result = self.run_cli("install", "vim")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("manager:activate vim", result.stdout)

    def test_update_runs_pacman_before_user_sync(self):
        result = self.run_cli("update")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout.splitlines(), ["sudo:pacman -Syu", "manager:update"])

    def test_failed_upgrade_does_not_sync(self):
        self.env["PACMAN_FAILURE"] = "1"
        result = self.run_cli("update")
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn("manager:", result.stdout)

    def test_partial_upgrades_are_rejected(self):
        self.assertEqual(self.run_cli("update", "nvim").returncode, 2)

    def test_git_mutation_commands_are_disabled(self):
        for command in ("push", "pull", "subtrees", "wallpapers"):
            self.assertEqual(self.run_cli(command).returncode, 1)

    def test_package_install_uses_full_upgrade(self):
        result = self.run_cli("packages", "arch-dotfiles-vim", "arch-dotfiles-tmux")
        self.assertIn("sudo:pacman -Syu --needed arch-dotfiles-vim arch-dotfiles-tmux", result.stdout)


if __name__ == "__main__":
    unittest.main()
