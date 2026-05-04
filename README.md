# Linux Setup

Personal Linux bootstrap scripts organized by installation category.

## Layout

- `install.sh`: main bootstrap entry point
- `packages.sh`: compatibility wrapper for core base packages
- `tools/core/`: baseline packages required by the setup
- `tools/system/`: system-level tools
- `tools/shell/`: shell and terminal workflow tools
- `tools/languages/`: language runtimes and package managers
- `tools/editors/`: editor tooling
- `tools/fonts/`: font installers
- `tools/desktop/`: optional graphical workstation applications
- `dotfiles/`: stow-managed dotfiles
- `bin/`: personal scripts linked into `~/.local/bin`

## Usage

Default setup:

```bash
./install.sh
```

Include optional desktop applications:

```bash
./install.sh --desktop
```

Adopt existing dotfiles into this repo before restowing:

```bash
./install.sh --adopt-dotfiles
```

Desktop app installers are intentionally skipped by default so the same repo can be used on servers, containers, WSL, and local workstations.
