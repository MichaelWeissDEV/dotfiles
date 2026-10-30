#!/usr/bin/env python3
"""Test signed packages in a disposable Pacman root and HOME, never on the host."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent


def run(arguments, **kwargs):
    result = subprocess.run(list(map(str, arguments)), text=True, capture_output=True, **kwargs)
    if result.returncode:
        raise RuntimeError(f"{arguments[0]} failed:\n{result.stdout}\n{result.stderr}")
    if Path(str(arguments[0])).name in ("nvim", "tmux") and result.stderr.strip():
        raise RuntimeError(f"Unexpected startup diagnostics from {arguments[0]}:\n{result.stderr}")
    return result.stdout


def main():
    if os.geteuid() == 0:
        raise RuntimeError("Run as an unprivileged user. This test never needs real root.")
    registry = json.loads((HERE / "packages.json").read_text())
    with tempfile.TemporaryDirectory(prefix="arch-dotfiles-smoke-") as temporary:
        temporary = Path(temporary)
        gnupg = temporary / "gnupg"
        gnupg.mkdir(mode=0o700)
        env = dict(os.environ, GNUPGHOME=str(gnupg), GPG_PASSPHRASE="")
        try:
            run(["gpg", "--batch", "--passphrase", "", "--quick-generate-key",
                 "Disposable package test <ci@example.invalid>", "ed25519", "sign", "1d"], env=env)
            keys = run(["gpg", "--batch", "--with-colons", "--list-secret-keys"], env=env)
            env["SIGNING_KEY"] = next(line.split(":")[9] for line in keys.splitlines() if line.startswith("fpr:"))
            stage = temporary / "build/packages"
            stage.mkdir(parents=True)
            for name in registry:
                outputs = run(["makepkg", "--packagelist"], cwd=HERE / "build" / name).splitlines()
                if len(outputs) != 1:
                    raise RuntimeError("Expected one package per recipe: " + name)
                package = Path(outputs[0])
                shutil.copy2(package, stage / package.name)
                shutil.copy2(str(package) + ".source.sha256", stage / (package.name + ".source.sha256"))
            repository = temporary / "repository"
            run(["bash", HERE / "create-repo.sh", repository, temporary / "build"], env=env)
            root = temporary / "root"
            database = root / "var/lib/pacman"
            database.mkdir(parents=True)
            cache = temporary / "cache"
            cache.mkdir()

            # Offline dependency resolution against the runner's already synced
            # official databases and our exact candidate packages. Never -Sy/-Syu,
            # never install official dependencies or edit the host pacman.conf.
            resolution = temporary / "resolution"
            (resolution / "sync").mkdir(parents=True)
            shutil.copy2(repository / "arch-dotfiles.db", resolution / "sync/arch-dotfiles.db")
            sections = [f"[arch-dotfiles]\nServer = file://{repository}\n"]
            for name in ("core", "extra"):
                official = Path("/var/lib/pacman/sync") / (name + ".db")
                if not official.exists():
                    raise RuntimeError("Official sync database missing: " + str(official))
                shutil.copy2(official, resolution / "sync" / official.name)
                sections.append(f"[{name}]\nServer = https://example.invalid/$repo/os/$arch\n")
            resolver = temporary / "resolve.conf"
            # Never is ONLY for this offline, read-only graph query. Actual package
            # installation below requires valid signatures and a separate config.
            resolver.write_text("[options]\nArchitecture = auto\nSigLevel = Never\n" + "\n".join(sections))
            run(["pacman", "--root", root, "--dbpath", resolution, "--config", resolver,
                 "--logfile", temporary / "resolve.log", "-Sp", "--print-format", "%n", "arch-dotfiles"])

            config = temporary / "pacman.conf"
            config.write_text(f"[options]\nArchitecture = auto\nSigLevel = Required DatabaseRequired\n"
                              f"LocalFileSigLevel = Required\nLogFile = {temporary}/pacman.log\n")
            command = ["fakeroot", "pacman", "--root", root, "--dbpath", database,
                       "--config", config, "--gpgdir", gnupg, "--cachedir", cache,
                       "-U", "--noconfirm", "--nodeps", "--nodeps", "--noscriptlet"]
            packages = sorted(repository.glob("*.pkg.tar.zst"))
            if len(packages) != len(registry):
                raise RuntimeError("Candidate repository is incomplete")
            # Local package installation must refuse a valid archive without its
            # required detached signature. This happens in the disposable root.
            unsigned = temporary / packages[0].name
            shutil.copy2(packages[0], unsigned)
            rejected = subprocess.run(list(map(str, [*command, unsigned])), env=env, capture_output=True)
            if rejected.returncode == 0:
                raise RuntimeError("Pacman incorrectly accepted a package without its required signature")
            run([*command, *packages], env=env)
            installed = run(["pacman", "--root", root, "--dbpath", database, "-Q"])
            if len(installed.splitlines()) != len(registry):
                raise RuntimeError("Not all candidate packages were installed")
            home = temporary / "home"
            (home / ".config/nvim").mkdir(parents=True)
            (home / ".config/nvim/previous").write_text("original user settings\n")
            user_env = dict(os.environ, HOME=str(home), XDG_CONFIG_HOME=str(home / ".config"),
                            XDG_DATA_HOME=str(home / ".local/share"), XDG_STATE_HOME=str(home / ".local/state"),
                            XDG_CACHE_HOME=str(home / ".cache"), SHELL="/bin/sh")
            defaults = root / "usr/share/arch-dotfiles"
            manager = ["python3", root / "usr/bin/arch-dotfiles-config"]
            run([*manager, "activate", "--defaults", defaults], env=user_env)
            for module in ("nvim", "tmux", "zsh"):
                if not (home / ".config" / module).is_symlink():
                    raise RuntimeError("Missing activated module: " + module)
            if shutil.which("nvim"):
                run(["nvim", "--headless", "-u", home / ".config/nvim/init.lua", "+qa"], env=user_env, timeout=30)
            if shutil.which("vim"):
                run(["vim", "-Nu", home / ".config/vim/vimrc", "-i", "NONE", "-n", "-es", "+qa"], env=user_env, timeout=30)
            if shutil.which("zsh"):
                run(["zsh", "-n", home / ".config/zsh/zshrc"], env=user_env)
                run(["zsh", "-n", home / ".config/zsh/aliases.zsh"], env=user_env)
            if shutil.which("tmux"):
                sockets = temporary / "sockets"
                sockets.mkdir()
                tmux_env = dict(user_env, TMUX_TMPDIR=str(sockets))
                tmux_env.pop("TMUX", None)
                try:
                    run(["tmux", "-L", "package-smoke", "-f", home / ".config/tmux/tmux.conf",
                         "new-session", "-d", "/bin/sh"], env=tmux_env)
                    if not run(["tmux", "-L", "package-smoke", "show", "-gv", "@thm_accent"], env=tmux_env).startswith("#"):
                        raise RuntimeError("Packaged tmux modules did not load")
                finally:
                    subprocess.run(["tmux", "-L", "package-smoke", "kill-server"], env=tmux_env, capture_output=True)
            edited = home / ".local/share/arch-dotfiles/config/tmux/tmux.conf"
            edited.write_text(edited.read_text() + "\n# personal customization\n")
            candidate = defaults / "tmux/tmux.conf"
            candidate.write_text(candidate.read_text() + "\n# new upstream default\n")
            run([*manager, "update", "--defaults", defaults], env=user_env)
            if "personal customization" not in edited.read_text() or not edited.with_name("tmux.conf.pacnew").exists():
                raise RuntimeError("Update did not preserve personal edits with .pacnew")
            run([*manager, "deactivate", "--defaults", defaults], env=user_env)
            if (home / ".config/nvim/previous").read_text() != "original user settings\n":
                raise RuntimeError("Previous user configuration was not restored")
        finally:
            subprocess.run(["gpgconf", "--kill", "gpg-agent"], env=env, capture_output=True)
    print("PASS: offline dependency resolution, mandatory signatures, 19-package installation,")
    print("editor/shell/tmux startup, activation, .pacnew updates and backup restoration in temporary roots.")


if __name__ == "__main__":
    main()
