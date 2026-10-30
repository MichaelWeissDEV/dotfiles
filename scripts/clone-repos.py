#!/usr/bin/env python3
"""Clone independent component repositories without overwriting local work."""
import argparse
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=ROOT.parent)
    parser.add_argument("--update", action="store_true", help="Fast-forward clean main branches only")
    parser.add_argument("--https", action="store_true", help="Use public HTTPS, e.g. in CI")
    args = parser.parse_args()
    args.root.mkdir(parents=True, exist_ok=True)
    repositories = json.loads((ROOT / "repositories.json").read_text())
    for repository in repositories.values():
        path = args.root / repository.split("/")[1]
        url = f"https://github.com/{repository}.git" if args.https else f"git@github.com:{repository}.git"
        if not path.exists():
            subprocess.run(["git", "clone", url, str(path)], check=True)
        else:
            origin = subprocess.check_output(["git", "-C", str(path), "remote", "get-url", "origin"], text=True).strip()
            if origin.removesuffix(".git").split("github.com")[-1].lstrip("/:") != repository:
                raise RuntimeError(f"Unexpected repository at {path}; left untouched")
            if args.update:
                if subprocess.check_output(["git", "-C", str(path), "status", "--porcelain"]):
                    raise RuntimeError(f"Local changes at {path}; refusing to update")
                branch = subprocess.check_output(["git", "-C", str(path), "branch", "--show-current"], text=True).strip()
                if branch != "main":
                    raise RuntimeError(f"{path} is not on main; left untouched")
                subprocess.run(["git", "-C", str(path), "pull", "--ff-only", "origin", "main"], check=True)
        print(path, flush=True)


if __name__ == "__main__":
    main()
