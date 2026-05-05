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
- `dotfiles/`: dotfiles installed by symlink or one-shot copy
- `bin/`: personal scripts installed into `~/.local/bin`

## Usage

Default setup:

```bash
./install.sh
```

Include optional desktop applications:

```bash
./install.sh --desktop
```

Install in one-shot mode so the cloned repo can be removed afterward:

```bash
./install.sh --one-shot
```

Adopt existing dotfiles into this repo before restowing:

```bash
./install.sh --adopt-dotfiles
```

Desktop app installers are intentionally skipped by default so the same repo can be used on servers, containers, WSL, and local workstations.

By default, dotfiles are managed as symlinks back to this repo with GNU Stow. Keep the cloned repo around when using the default mode. Use `--one-shot` when you want dotfiles and personal scripts copied into place instead.

## Sudo Requirements

The default full bootstrap assumes the user has `sudo` access on a Debian/Ubuntu-like system. It installs baseline apt packages first, so `./install.sh` requires sudo immediately.

Sudo-required installers:

- `tools/core/packages.sh`: base apt packages and apt cleanup
- `tools/languages/python.sh`: Python apt packages
- `tools/system/docker.sh`: Docker apt repository, packages, and group setup
- `tools/system/eza.sh`: eza apt repository and package
- `tools/system/lazygit.sh`: installs the binary into `/usr/local/bin`
- `tools/shell/zellij.sh`: installs the binary into `/usr/local/bin`
- `tools/shell/zsh.sh`: installs zsh via apt when missing and changes the login shell when possible
- `tools/editors/neovim.sh`: installs into `/opt` and links into `/usr/local/bin`
- `tools/desktop/vscode.sh`: Microsoft apt repository and VS Code package
- `tools/desktop/hyper.sh`: Hyper `.deb` package installation

User-local installers that do not require sudo when their prerequisites already exist:

- `tools/install_bin.sh`: installs personal scripts into `~/.local/bin`
- `tools/install_dotfiles.sh`: installs dotfiles under `$HOME`
- `tools/install_font.sh`: installs fonts into `~/.local/share/fonts`
- `tools/languages/miniconda.sh`: installs into `~/miniconda3`
- `tools/languages/nvm.sh`: installs into `~/.nvm`
- `tools/languages/poetry.sh`: installs Poetry into user-local paths
- `tools/languages/uv.sh`: installs uv into user-local paths
- `tools/shell/zoxide.sh`: installs zoxide into user-local paths
- `tools/editors/lazyvim.sh`: installs Neovim config into `~/.config/nvim`
