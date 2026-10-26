# Frequently Asked Questions

This section answers common questions regarding `vim-config`, system clipboard sharing, persistent undo history, and differences with Neovim.

---

## Clipboard & Sharing

### Why does `<Space>y` fail to copy to my system clipboard?

In Vim, system clipboard access requires the binary to be compiled with `+clipboard`:

1. **Verify your Vim build**:
   ```bash
   vim --version | grep '\+clipboard'
   ```
   If it prints `-clipboard`, your distribution's default package is a minimal headless build.

2. **Install a clipboard-enabled Vim**:
   - **Arch Linux**:
     ```bash
     sudo pacman -S gvim
     ```
     *(Note: `gvim` provides the CLI `vim` binary compiled with full `+clipboard` support.)*
   - **Debian / Ubuntu**:
     ```bash
     sudo apt install vim-gtk3
     ```

3. **Wayland Tools**:
   Ensure `wl-clipboard` is installed if you run a Wayland compositor such as Hyprland or Sway.

---

## Workflow & Hygiene

### Where are undo files stored, and how do I clean them?

Undo files are automatically stored under the XDG state directory:
```bash
~/.local/state/vim/undo/
```
No `.un~` files are written into your code repositories or home folder. To clear all historical undo snapshots:
```bash
rm -rf ~/.local/state/vim/undo/*
```

### How do I reload my Vim configuration without restarting?

Run the following inside Vim:
```vim
:source $MYVIMRC
```
All keybindings, colors, and statusline functions reload immediately.

---

## Architecture & Ecosystem

### Why use zero plugins instead of a plugin manager?

Modern plugin managers (`vim-plug`, `packer`, `lazy.nvim`) are powerful, but add dependencies on git, internet access during install, and language runtimes (Node.js, Python, Lua).

`vim-config` is intentionally designed as an **ultra-reliable, zero-dependency environment**:
- Starts in **under 10 milliseconds**.
- Requires zero network requests on first run.
- Runs identically across minimal Linux servers, containers, macOS, and BSD systems.
- Serves as the ultimate fail-safe editor when Neovim or heavy LSP installations are unavailable or undergoing maintenance.

### When should I use `vim-config` vs `nvim-config`?

- **Use [`nvim-config`](https://nvim-config.readthedocs.io/en/latest/)** for primary software engineering, full IDE features, LSP diagnostics, Treesitter AST highlighting, fuzzy finding with Snacks/Telescope, and Git blame overlays.
- **Use `vim-config`** for remote SSH sessions, quick config file editing (`/etc/...`), lightweight systems, or as a fast fallback editor with identical navigation shortcuts.
