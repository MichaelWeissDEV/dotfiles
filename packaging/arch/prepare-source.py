#!/usr/bin/env python3
"""Prepare one isolated makepkg source per package; never export private files."""
import argparse
import gzip
import hashlib
import json
import os
import re
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
PACKAGES = ROOT / "packages"
REGISTRY = json.loads((HERE / "packages.json").read_text())
REPOSITORIES = json.loads((ROOT / "repositories.json").read_text())
SOURCE_ROOT = Path(os.environ.get("ARCH_DOTFILES_SOURCE_ROOT", ROOT.parent))
PRIVATE = {"hypr/monitors.local.lua", "tmux/local.conf", "tmux/local-options.conf"}
CORE_FILES = ("adot", "arch-dotfiles-config", "package-command", "arch-dotfiles.install",
              "BUNDLE-LICENSE", "arch-dotfiles-sync.service", "arch-dotfiles-sync.timer",
              "arch-dotfiles-registry-kick", "arch-dotfiles-registry-kick.service",
              "arch-dotfiles-registry-kick.timer")


def tracked_files(root=None):
    output = subprocess.check_output(["git", "-C", str(root or ROOT), "ls-files", "-z"])
    return {os.fsdecode(p) for p in output.split(b"\0") if p}


def component_root(module):
    return SOURCE_ROOT / REPOSITORIES[module].split("/")[1]


def package_recipe(name):
    module = REGISTRY[name].get("module")
    return component_root(module) / "packaging/arch/PKGBUILD" if module else PACKAGES / name / "PKGBUILD"


def revision(root):
    shallow = subprocess.check_output(["git", "-C", str(root), "rev-parse", "--is-shallow-repository"], text=True).strip()
    if shallow == "true":
        raise RuntimeError(f"Full Git history required for monotonic package versions: {root}")
    count = subprocess.check_output(["git", "-C", str(root), "rev-list", "--count", "HEAD"], text=True).strip()
    commit = subprocess.check_output(["git", "-C", str(root), "rev-parse", "--short=12", "HEAD"], text=True).strip()
    dirty = bool(subprocess.check_output(["git", "-C", str(root), "status", "--porcelain", "--untracked-files=no"]))
    return count, commit, dirty


def metadata(name):
    data = dict(REGISTRY[name])
    depends = list(data.get("depends", []))
    if "module" in data:
        # The component owns its recipe and dependencies; no duplicate hub edits.
        depends = subprocess.check_output([
            "bash", "-c", 'source "$1"; printf "%s\\n" "${depends[@]}"',
            "bash", str(package_recipe(name))
        ], text=True).splitlines()
    if data.get("kind") == "meta":
        depends += [p for p, item in REGISTRY.items() if "module" in item]
    data["depends"] = depends
    return data


def recipe(name):
    data = metadata(name)
    if "module" in data:
        raise RuntimeError("Component recipes are maintained in their own repository.")
    def array(values):
        return "(" + " ".join("'" + v + "'" for v in values) + ")"
    lines = ["# Package-local recipe. Stage checksummed sources with packaging/arch/build.sh.",
             f"pkgname={name}", "pkgver=0.3.0", "pkgrel=1",
             f"pkgdesc='{data['description']}'", "arch=('any')",
             "url='https://github.com/MichaelWeissDEV/dotfiles'",
             "license=('LicenseRef-arch-dotfiles-bundle')",
             "depends=" + array(data["depends"]),
             "optdepends=" + array(data.get("optdepends", [])), "options=('!strip')",
             "source=('payload.tar.gz')", "sha256sums=('__SOURCE_SHA256__')"]
    if data.get("kind") == "oh-my-zsh":
        lines += ["_omz_commit=17a2b4c3a5855524ad4772a17ada0dc474e2fdf3",
                  'source+=("ohmyzsh-${_omz_commit}.tar.gz::https://codeload.github.com/ohmyzsh/ohmyzsh/tar.gz/${_omz_commit}")',
                  "sha256sums+=('eb6f2788316ff75f9be60c00372da0da97d4bcab202d64a9229e1f6365166932')"]
    if data.get("kind") == "core":
        lines += ["install=arch-dotfiles.install"]
    lines += ["", "package() {", '    cp -a "$srcdir/usr" "$pkgdir/"']
    if data.get("kind") == "oh-my-zsh":
        lines += ['    cp -a "$srcdir/ohmyzsh-$_omz_commit" "$pkgdir/usr/share/arch-dotfiles/oh-my-zsh"']
    lines += ["}", ""]
    return "\n".join(lines)


def copy(source, destination):
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination, follow_symlinks=False)


def stage(name, destination, tracked=None):
    data = REGISTRY[name]
    package = PACKAGES / name
    share = destination / "usr/share/arch-dotfiles"
    share.mkdir(parents=True)
    module = data.get("module")
    origin = component_root(module) if module else ROOT
    license_file = origin / "LICENSE" if (origin / "LICENSE").is_file() else ROOT / "LICENSE"
    copy(license_file, destination / f"usr/share/licenses/{name}/LICENSE")
    copy(PACKAGES / "arch-dotfiles-core/BUNDLE-LICENSE",
         destination / f"usr/share/licenses/{name}/BUNDLE-LICENSE")
    if module:
        tracked = tracked_files(origin) if tracked is None else tracked
        for filename in sorted(tracked):
            source = origin / filename
            if not source.is_file() and not source.is_symlink():
                continue
            relative = source.relative_to(origin)
            old_name = f"{module}/{relative.as_posix()}"
            if old_name in PRIVATE or ".git" in relative.parts or relative.parts[0] in (".github", "packaging"):
                continue
            if old_name.startswith("nvim/pack/vendor/start/LuaSnip/tests/parsers/"):
                continue
            if relative.as_posix() not in tracked:
                continue
            copy(source, share / module / relative)
        inventory = share / "modules.d" / module
        inventory.parent.mkdir(exist_ok=True)
        inventory.write_text(module + "\n")
        if module == "zsh":
            (share / module / "PACKAGED").write_text("pacman\n")
        if module in ("hypr", "wallpaper"):
            command = "screenshot" if module == "hypr" else "wallpaper"
            binary = destination / "usr/bin" / command
            binary.parent.mkdir(parents=True, exist_ok=True)
            binary.symlink_to("/usr/share/arch-dotfiles/package-command")
        if module == "hypr":
            copy(share / "hypr/screenshot.desktop",
                 destination / "usr/share/applications/dotfiles-screenshot.desktop")
        for script in (share / module).rglob("*.sh"):
            if not script.is_symlink():
                script.chmod(script.stat().st_mode | 0o111)
    elif data.get("kind") == "core":
        for filename in CORE_FILES:
            source = package / filename
            if filename in ("adot", "arch-dotfiles-config", "arch-dotfiles-registry-kick"):
                target = destination / "usr/bin" / filename
            elif filename.endswith((".service", ".timer")):
                target = destination / "usr/lib/systemd/user" / filename
            elif filename == "arch-dotfiles.install":
                continue
            else:
                target = share / filename
            copy(source, target)
            if filename in ("adot", "arch-dotfiles-config", "package-command",
                            "arch-dotfiles-registry-kick"):
                target.chmod(0o755)
        for alias in ("arch-dot", "arch-dotfiles"):
            (destination / "usr/bin" / alias).symlink_to("adot")
        copy(HERE / "README.md", destination / "usr/share/doc/arch-dotfiles/README.md")


def prepare(name, output=None):
    if name not in REGISTRY:
        raise ValueError(f"Unknown package: {name}")
    build = Path(output or HERE / "build") / name
    build.mkdir(parents=True, exist_ok=True)
    # Content fingerprint must not change when an unrelated package is committed.
    epoch = 0
    with tempfile.TemporaryDirectory(prefix="dotfiles-source-") as temporary:
        tree = Path(temporary)
        stage(name, tree)
        archive = build / "payload.tar.gz"
        with archive.open("wb") as raw, gzip.GzipFile(fileobj=raw, mode="wb", filename="", mtime=epoch) as gz:
            with tarfile.open(fileobj=gz, mode="w") as tar:
                for source in sorted(tree.rglob("*")):
                    info = tar.gettarinfo(str(source), arcname=source.relative_to(tree).as_posix())
                    info.uid = info.gid = 0
                    info.uname = info.gname = "root"
                    info.mtime = epoch
                    if info.isfile():
                        with source.open("rb") as stream:
                            tar.addfile(info, stream)
                    else:
                        tar.addfile(info)
    text = package_recipe(name).read_text()
    module = REGISTRY[name].get("module")
    count, commit, dirty = revision(component_root(module) if module else ROOT)
    hub_count, _, _ = revision(ROOT)
    text = re.sub(r"^pkgver=([^\n]+)$", lambda match: f"pkgver={match[1]}.r{count}.g{commit}" + (".dirty" if dirty else ""), text, flags=re.M)
    # A central packaging change must also produce a newer revision of unchanged components.
    text = re.sub(r"^pkgrel=.*$", f"pkgrel={hub_count}", text, flags=re.M)
    text = text.replace("__SOURCE_SHA256__", hashlib.sha256(archive.read_bytes()).hexdigest())
    (build / "PKGBUILD").write_text(text)
    if REGISTRY[name].get("kind") == "core":
        copy(PACKAGES / name / "arch-dotfiles.install", build / "arch-dotfiles.install")
    digest = hashlib.sha256()
    for filename in ("PKGBUILD", "payload.tar.gz", "arch-dotfiles.install"):
        if (build / filename).exists():
            digest.update(filename.encode() + b"\0" + (build / filename).read_bytes())
    (build / "source.sha256").write_text(digest.hexdigest() + "\n")
    print(build)
    return build


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("packages", nargs="*", choices=[*REGISTRY, "all"])
    parser.add_argument("--init-recipes", action="store_true", help="Create missing package recipes only")
    args = parser.parse_args()
    for name in REGISTRY if not args.packages or "all" in args.packages else args.packages:
        if args.init_recipes:
            if "module" in REGISTRY[name]:
                continue
            directory = PACKAGES / name
            directory.mkdir(exist_ok=True)
            target = directory / "PKGBUILD"
            if not target.exists():
                target.write_text(recipe(name))
        else:
            prepare(name)


if __name__ == "__main__":
    main()
