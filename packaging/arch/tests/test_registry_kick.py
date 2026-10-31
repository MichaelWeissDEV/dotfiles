import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[3]
HUB = "MichaelWeissDEV/dotfiles"

SOURCES = {
    "distribution": "1111111111111111111111111111111111111111",
    "components": {
        "foot": {"repository": "MichaelWeissDEV/foot-config",
                 "commit": "2222222222222222222222222222222222222222"},
        "tmux": {"repository": "MichaelWeissDEV/tmux-config",
                 "commit": "3333333333333333333333333333333333333333"},
        "vim": {"repository": "MichaelWeissDEV/vim-config",
                "commit": "4444444444444444444444444444444444444444"},
    },
}

EVERYTHING_CURRENT = {
    HUB: SOURCES["distribution"],
    **{item["repository"]: item["commit"] for item in SOURCES["components"].values()},
}

# A gh stand-in that accepts the calls the kick script makes, whatever order
# the arguments arrive in: the octet-stream asset fetch includes options
# before the URL, so matching must scan for a repos/... token.
STUB_GH = r"""#!/bin/bash
printf '%s\n' "$*" >>"${KICK_CALLS}"
[ "$1" = "auth" ] && exit "${KICK_AUTH_FAIL:-0}"
url=""
for arg in "$@"; do
  case "$arg" in repos/*) url="$arg"; break ;; esac
done
case "$1/$2" in
  workflow/run) exit 0 ;;
esac
case "$url" in
  repos/MichaelWeissDEV/dotfiles/releases/tags/repo)
    ${KICK_NO_ASSET:+:} echo 12345 ;;
  repos/MichaelWeissDEV/dotfiles/releases/assets/12345)
    cat "${KICK_SOURCES}" ;;
  repos/*/branches/main)
    repo="${url#repos/}"
    repo="${repo%/branches/main}"
    sha="$(awk -F"\t" -v r="$repo" '$1 == r { print $2 }' "${KICK_HEADS}")"
    [ -n "$sha" ] && { echo "$sha"; exit 0; }
    exit 9 ;;
  *) exit 3 ;;
esac
"""


class RegistryKickTest(unittest.TestCase):
    def setUp(self):
        temp = tempfile.TemporaryDirectory()
        self.addCleanup(temp.cleanup)
        self.temp = Path(temp.name)
        (self.temp / "bin").mkdir()
        (self.temp / "state").mkdir()

        stub = self.temp / "bin" / "gh"
        stub.write_text(STUB_GH)
        stub.chmod(0o755)

        self.env = dict(
            os.environ,
            HOME=self.temp.as_posix(),
            XDG_STATE_HOME=self.temp.joinpath("state").as_posix(),
            PATH=(self.temp / "bin").as_posix() + os.pathsep + os.environ["PATH"],
            KICK_CALLS=self.temp.joinpath("calls").as_posix(),
            KICK_SOURCES=self.temp.joinpath("sources.json").as_posix(),
            KICK_HEADS=self.temp.joinpath("heads.tsv").as_posix(),
        )
        self.command = ["bash", str(ROOT / "packages/arch-dotfiles-core/arch-dotfiles-registry-kick")]

    def publish(self, heads):
        (self.temp / "sources.json").write_text(json.dumps(SOURCES) + "\n")
        (self.temp / "heads.tsv").write_text(
            "\n".join(f"{repo}\t{commit}" for repo, commit in heads.items()) + "\n")

    def run_kick(self):
        return subprocess.run(self.command, env=self.env, text=True, capture_output=True)

    def gh_arguments(self):
        calls = self.temp / "calls"
        if not calls.is_file():
            return []
        return [line for line in calls.read_text().splitlines() if line.strip()]

    def dispatched(self):
        return any(line.startswith("workflow run") for line in self.gh_arguments())

    def test_everything_current_prints_nothing_and_dispatches_nothing(self):
        self.publish(EVERYTHING_CURRENT)
        result = self.run_kick()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, "")
        self.assertFalse(self.dispatched())

    def test_ahead_component_is_named_and_dispatched(self):
        heads = dict(EVERYTHING_CURRENT)
        heads["MichaelWeissDEV/tmux-config"] = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        self.publish(heads)
        result = self.run_kick()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(self.dispatched())
        self.assertIn("dispatched 'Arch packages' in MichaelWeissDEV/dotfiles", result.stdout)
        self.assertIn("tmux-config", result.stdout)
        self.assertIn(SOURCES["components"]["tmux"]["commit"], result.stdout)
        self.assertIn("a" * 40, result.stdout)
        self.assertIn("(1 source(s) ahead)", result.stdout)

    def test_without_the_sources_asset_everything_counts_as_behind(self):
        self.publish(EVERYTHING_CURRENT)
        self.env["KICK_NO_ASSET"] = "yes"
        result = self.run_kick()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("no published registry release yet", result.stderr)
        self.assertTrue(self.dispatched())

    def test_unauthenticated_yields_to_the_cron(self):
        self.publish(EVERYTHING_CURRENT)
        self.env["KICK_AUTH_FAIL"] = "1"
        result = self.run_kick()
        self.assertEqual(result.returncode, 0)
        self.assertIn("gh auth login", result.stderr)
        self.assertFalse(self.dispatched())

    def test_github_unreachable_is_treated_as_transient(self):
        heads = {repo: sha for repo, sha in EVERYTHING_CURRENT.items() if repo != HUB}
        self.publish(heads)
        result = self.run_kick()
        self.assertEqual(result.returncode, 0)
        self.assertIn("GitHub not reachable", result.stderr)
        self.assertFalse(self.dispatched())


if __name__ == "__main__":
    unittest.main()
