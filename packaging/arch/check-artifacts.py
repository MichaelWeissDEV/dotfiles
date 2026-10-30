#!/usr/bin/env python3
"""Check built archives for ownership collisions, private files and malformed payloads."""
import json
from pathlib import Path, PurePosixPath
import subprocess
import tarfile

HERE = Path(__file__).resolve().parent


def main():
    registry = json.loads((HERE / "packages.json").read_text())
    owners = {}
    count = 0
    for name in registry:
        directory = HERE / "build" / name
        paths = subprocess.check_output(["makepkg", "--packagelist"], cwd=directory, text=True).splitlines()
        if len(paths) != 1:
            raise RuntimeError(f"Expected exactly one artifact for {name}")
        archive = Path(paths[0])
        if not Path(str(archive) + ".source.sha256").is_file():
            raise RuntimeError(f"Missing source fingerprint for {name}")
        with subprocess.Popen(["zstd", "-dc", str(archive)], stdout=subprocess.PIPE) as process:
            with tarfile.open(fileobj=process.stdout, mode="r|") as tar:
                for item in tar:
                    path = PurePosixPath(item.name)
                    if path.is_absolute() or ".." in path.parts or ".git" in path.parts:
                        raise RuntimeError(f"Unsafe payload path in {name}: {path}")
                    if item.uid != 0 or item.gid != 0:
                        raise RuntimeError(f"Non-root package ownership in {name}: {path}")
                    if "pictures" in path.parts or path.name in ("monitors.local.lua", "local-options.conf"):
                        raise RuntimeError(f"Private payload in {name}: {path}")
                    if path.name == "local.conf" and str(path).startswith("usr/share/arch-dotfiles/tmux/"):
                        raise RuntimeError(f"Private tmux override in {name}")
                    if item.isdir() or path.parts[0].startswith("."):
                        continue
                    if path.parts[0] != "usr":
                        raise RuntimeError(f"Payload outside /usr: {path}")
                    if str(path) in owners:
                        raise RuntimeError(f"File collision: {path}: {owners[str(path)]}, {name}")
                    owners[str(path)] = name
                    count += 1
            if process.wait() != 0:
                raise RuntimeError(f"Could not decompress {archive}")
    print(f"Validated {len(registry)} archives; {count} uniquely-owned payload files, all root-owned.")


if __name__ == "__main__":
    main()
