# Dotfiles

Personal development environment configuration files.

## What's Included

- **Neovim** - LazyVim-based configuration
- **WezTerm** - Terminal emulator
- **Yazi** - Terminal file manager
- **Zsh** - Shell with Oh-My-Zsh + Powerlevel10k
- **Git** - Multi-account config (personal + work)
- **SSH** - Multi-account config

## Requirements

### Homebrew packages
| Package | Description |
|---------|-------------|
| `neovim` | Text editor |
| `git` | Version control (Homebrew version for `hasconfig` support) |
| `eza` | Better `ls` |
| `zoxide` | Better `cd` |
| `lazygit` | Git TUI |
| `yazi` | File manager |
| `fzf` | Fuzzy finder |
| `ripgrep` | Fast grep (used by Telescope) |
| `fd` | Fast find (used by Telescope) |
| `lua` | Lua runtime |
| `luarocks` | Lua package manager |

### Casks
| Package | Description |
|---------|-------------|
| `font-jetbrains-mono-nerd-font` | Terminal font |
| `wezterm` | Terminal emulator |

### Version managers
| Tool | Description | Install |
|------|-------------|---------|
| `nvm` | Node Version Manager | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh \| bash` |
| `gvm` | Go Version Manager | `bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)` |
| `rye` | Python Version + Package Manager | `curl -sSf https://rye.astral.sh/get \| RYE_INSTALL_OPTION="--yes" bash` |

### Neovim LSP / tools (auto-installed via Mason)
`gopls` `gofumpt` `goimports` `golangci-lint` `delve` `pyright` `ruff` `debugpy` `vtsls` `clangd` `clang-format` `codelldb` `stylua` `shellcheck` `shfmt`

---

## macOS Setup

### 1. Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Core tools

```bash
brew install neovim git zsh ripgrep fd node eza zoxide lazygit yazi fzf
```

### 3. NVM (Node Version Manager)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
```

### 4. GVM (Go Version Manager)

```bash
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```

Install Go (use `-B` for binary, no bootstrap needed):
```bash
gvm install go1.x.x -B
gvm use go1.x.x --default
```

### 5. Nerd Font

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### 6. Oh-My-Zsh + plugins

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 7. Symlink dotfiles

```bash
# Zsh
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh

# Neovim
ln -s ~/.dotfiles/nvim ~/.config/nvim

# WezTerm
ln -s ~/.dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua

# Yazi
ln -s ~/.dotfiles/yazi ~/.config/yazi

# Git
ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/.gitconfig-personal ~/.gitconfig-personal
ln -s ~/.dotfiles/git/.gitconfig-work ~/.gitconfig-work

# SSH
ln -s ~/.dotfiles/ssh/config ~/.ssh/config

# Scripts
mkdir -p ~/bin
```

### 8. macOS key repeat (for Neovim navigation)

Reduces key repeat delay for faster cursor movement:

```bash
# Reduce key repeat delay
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain KeyRepeat -int 1

# Disable press-and-hold accent popup (enables key repeat in Neovim)
defaults write -g ApplePressAndHoldEnabled -bool false
```

> Requires logout/login to take effect.

## Yazi

### Git status plugin

The `git.yazi` plugin shows git status icons for files and folders.

After symlinking the dotfiles, install/update the plugin:

```bash
ya pkg install
```

To update later:

```bash
ya pkg upgrade
```

Config is in `yazi/yazi.toml` — the fetchers are already set up:

```toml
[[plugin.prepend_fetchers]]
id = "git"
name = "*"
run = "git"

[[plugin.prepend_fetchers]]
id = "git"
name = "*/"
run = "git"
```

---

## SSH Multi-account (GitHub)

Clone with the appropriate host alias:

```bash
# Personal
git clone git@github-personal:username/repo.git

# Work
git clone git@github-work:username/repo.git
```

Git will automatically use the correct `user.name` and `user.email` based on the remote URL.
