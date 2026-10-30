#!/usr/bin/env python3
"""Detect source changes before building; stdout is suitable for a CI step output."""
import argparse
import json
from pathlib import Path
import subprocess
import os

ROOT = Path(__file__).resolve().parents[2]


def head(path):
    return subprocess.check_output(["git", "-C", str(path), "rev-parse", "HEAD"], text=True).strip()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--compare", type=Path)
    parser.add_argument("--output", type=Path, default=ROOT / "sources.json")
    args = parser.parse_args()
    repositories = json.loads((ROOT / "repositories.json").read_text())
    source_root = Path(os.environ.get("ARCH_DOTFILES_SOURCE_ROOT", ROOT.parent))
    snapshot = {"distribution": head(ROOT), "components": {
        name: {"repository": repo, "commit": head(source_root / repo.split("/")[1])}
        for name, repo in repositories.items()
    }}
    previous = json.loads(args.compare.read_text()) if args.compare and args.compare.exists() else None
    args.output.write_text(json.dumps(snapshot, indent=2, sort_keys=True) + "\n")
    print("true" if snapshot != previous else "false")


if __name__ == "__main__":
    main()
