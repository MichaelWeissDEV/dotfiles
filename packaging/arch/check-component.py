#!/usr/bin/env python3
"""Fast, unprivileged component checks. Never install packages or activate user settings."""
import argparse
import ast
import configparser
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile
import tomllib
import xml.etree.ElementTree as ET

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("component_source", HERE / "prepare-source.py")
source = importlib.util.module_from_spec(spec)
spec.loader.exec_module(source)
ENTRYPOINTS = {
    "foot": "foot.ini", "fuzzel": "fuzzel.ini", "ghostty": "config",
    "gtk-3.0": "settings.ini", "gtk-4.0": "settings.ini", "hypr": "hyprland.lua",
    "kitty": "kitty.conf", "libfm": "libfm.conf", "nvim": "init.lua",
    "pcmanfm": "default/pcmanfm.conf", "tmux": "tmux.conf", "vim": "vimrc",
    "wallpaper": "wallpaper.sh", "waybar": "config.jsonc", "yazi": "yazi.toml", "zsh": "zshrc",
}


def jsonc(text):
    """Remove JSONC comments/trailing commas without changing quoted strings."""
    output = []
    index = 0
    quoted = False
    while index < len(text):
        char = text[index]
        if quoted:
            output.append(char)
            if char == "\\" and index + 1 < len(text):
                index += 1
                output.append(text[index])
            elif char == '"':
                quoted = False
        elif char == '"':
            quoted = True
            output.append(char)
        elif text.startswith("//", index):
            end = text.find("\n", index)
            index = len(text) if end == -1 else end
            output.append("\n")
            continue
        elif text.startswith("/*", index):
            end = text.find("*/", index + 2)
            if end == -1:
                raise ValueError("Unterminated JSONC comment")
            index = end + 2
            output.append(" ")
            continue
        else:
            output.append(char)
        index += 1
    text = "".join(output)
    output = []
    index = 0
    quoted = False
    while index < len(text):
        char = text[index]
        if quoted:
            output.append(char)
            if char == "\\" and index + 1 < len(text):
                index += 1
                output.append(text[index])
            elif char == '"':
                quoted = False
        else:
            if char == '"':
                quoted = True
            if char != "," or not re.match(r"\s*[}\]]", text[index + 1:]):
                output.append(char)
        index += 1
    def unique(pairs):
        result = {}
        for key, value in pairs:
            if key in result:
                raise ValueError("Duplicate JSON key: " + key)
            result[key] = value
        return result
    return json.loads("".join(output), object_pairs_hook=unique)


def check(module):
    origin = source.component_root(module)
    name = "arch-dotfiles-" + module
    recipe = source.package_recipe(name)
    subprocess.run(["bash", "-n", str(recipe)], check=True)
    result = subprocess.check_output([
        "bash", "-c", 'source "$1"; printf "%s\\n" "$pkgname" "${install:-}" "${depends[@]}"',
        "bash", str(recipe)
    ], text=True).splitlines()
    if result[0] != name or result[1]:
        raise RuntimeError("Wrong package name or unexpected root-owned install scriptlet: " + name)
    if not any(dependency.startswith("arch-dotfiles-core>=") for dependency in result[2:]):
        raise RuntimeError("Missing versioned core dependency: " + name)
    tracked = source.tracked_files(origin)
    for filename in tracked:
        path = origin / filename
        if not path.is_file() or path.is_symlink() or Path(filename).parts[0] in ("pack", "vendor", "flavors", ".git"):
            continue
        if path.suffix == ".sh":
            subprocess.run(["bash", "-n", str(path)], check=True)
        elif path.suffix == ".py":
            ast.parse(path.read_text(), filename=filename)
        elif path.suffix == ".toml":
            tomllib.loads(path.read_text())
        elif path.suffix == ".jsonc":
            jsonc(path.read_text())
        elif path.suffix == ".xml":
            ET.parse(path)
        elif path.suffix == ".ini" or (module in ("libfm", "pcmanfm") and path.suffix == ".conf"):
            config = configparser.ConfigParser(interpolation=None)
            config.read_string(path.read_text())
    with tempfile.TemporaryDirectory(prefix="component-check-") as temporary:
        tree = Path(temporary)
        source.stage(name, tree)
        defaults = tree / "usr/share/arch-dotfiles"
        if not (defaults / module / ENTRYPOINTS[module]).is_file():
            raise RuntimeError("Missing runtime entrypoint: " + module)
        if (defaults / "modules.d" / module).read_text() != module + "\n":
            raise RuntimeError("Invalid module inventory: " + module)
        for path in tree.rglob("*"):
            relative = path.relative_to(tree)
            if relative.parts[0] != "usr" or ".git" in relative.parts:
                raise RuntimeError("Payload outside /usr or Git metadata leaked: " + str(relative))
            if path.is_symlink():
                target = os.readlink(path)
                if target.startswith("/"):
                    if target != "/usr/share/arch-dotfiles/package-command":
                        raise RuntimeError("Unexpected absolute symlink: " + str(relative))
                elif not Path(os.path.normpath(path.parent / target)).is_relative_to(tree / "usr"):
                    raise RuntimeError("Symlink escapes the package payload: " + str(relative))
    print(name + ": recipe, syntax, runtime entrypoint and isolated /usr payload OK")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repository", help="GitHub owner/repository of one component")
    parser.add_argument("--github-output", type=Path)
    args = parser.parse_args()
    modules = [module for module, repo in source.REPOSITORIES.items() if not args.repository or repo == args.repository]
    if not modules:
        parser.error("Unknown component repository")
    for module in modules:
        check(module)
    if args.github_output:
        config = source.component_root(modules[0]) / ".readthedocs.yaml"
        python = re.search(r'python:\s*["\x27]?([0-9.]+)', config.read_text()) if config.exists() else None
        with args.github_output.open("a") as output:
            output.write(f"docs={'true' if config.exists() else 'false'}\n")
            output.write(f"python={python[1] if python else '3.13'}\n")


if __name__ == "__main__":
    main()
