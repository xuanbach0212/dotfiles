# Dotfiles

Personal development environment configuration files.

## 📦 What's Included

- **Neovim** - LazyVim-based configuration with custom plugins
- **Wezterm** - Terminal emulator with Symbols Nerd Font
- **Yazi** - Terminal file manager with git integration
- **Zsh** - Shell configuration with Powerlevel10k theme
- **Git** - Global gitignore patterns

## 🚀 Quick Install

### Step 1: Install Dependencies

**macOS:**
```bash
# Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tools
brew install neovim git zsh ripgrep fd node

# Optional but recommended
brew install lazygit yazi fzf

# Install a Nerd Font
brew tap homebrew/cask-fonts
brew install font-symbols-only-nerd-font

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

**Linux (Debian/Ubuntu):**
```bash
# Core tools
sudo apt update
sudo apt install neovim git zsh ripgrep fd-find nodejs npm

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Nerd Font manually from: https://www.nerdfonts.com/
```

### Step 2: Clone and Install Dotfiles

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles

# Run install script
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

### Step 3: Finalize Setup

```bash
# Set Zsh as default shell
chsh -s $(which zsh)

# Configure Powerlevel10k (first time opening terminal)
# Follow the interactive prompts

# Open Neovim to install plugins
nvim
# Wait for lazy.nvim to install all plugins
# LSP servers will be auto-installed by Mason

# Restart terminal
exec zsh
```

## 📋 Manual Installation

### Prerequisites

**Required:**
- Neovim >= 0.9.0
- Git
- A Nerd Font (recommend: Symbols Nerd Font Mono)

**Optional:**
- Ripgrep (for Telescope search)
- fd (for file finding)
- lazygit (for git integration)

### Installation Steps

```bash
# 1. Backup existing configs
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.config/yazi ~/.config/yazi.backup
mv ~/.wezterm.lua ~/.wezterm.lua.backup
mv ~/.zshrc ~/.zshrc.backup

# 2. Create symlinks
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/yazi ~/.config/yazi
ln -s ~/dotfiles/wezterm/.wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
ln -s ~/dotfiles/git/ignore ~/.config/git/ignore

# 3. Install Neovim plugins
nvim
# Lazy.nvim will auto-install plugins on first launch

# 4. Install Yazi plugins (for git status)
# Already configured in yazi/init.lua
```

## 🔧 Configuration Details

### Neovim

- **Plugin Manager:** lazy.nvim
- **Distribution:** LazyVim
- **Icon Provider:** nvim-web-devicons (Nerd Font icons)
- **File Explorer:** neo-tree.nvim
- **Fuzzy Finder:** telescope.nvim
- **Git Integration:** gitsigns.nvim
- **Terminal:** toggleterm.nvim
- **AI:** GitHub Copilot
- **Colorscheme:** Catppuccin Macchiato

**Key Features:**
- Hidden files visible in telescope/neo-tree
- LSP support for multiple languages via Mason
- Git status in file explorers
- Custom keymaps (see `nvim/lua/config/keymaps.lua`)

### Wezterm

- **Font:** Symbols Nerd Font Mono
- Terminal configuration optimized for development

### Yazi

- **Features:**
  - Git status icons for files and folders
  - Hidden files visible
  - Symlink support

### Zsh

- **Theme:** Powerlevel10k
- **Features:**
  - FZF integration
  - Custom aliases and functions

## ⌨️ Key Mappings (Neovim)

### General
- `jk` (insert mode) - Exit to normal mode

### File Navigation
- `<leader>e` - Toggle Neo-tree (root dir)
- `<leader>E` - Toggle Neo-tree (cwd)

### Search
- `<leader>ff` - Find files (respects .gitignore)
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers

### Terminal
- `<Ctrl-\>` - Toggle terminal

## 🛠️ Customization

### Adding LSP Servers

```lua
-- nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        your_lsp = {},  -- Will be auto-installed by Mason
      },
    },
  },
}
```

### Changing Colorscheme

Edit `nvim/lua/plugins/colorschema.lua`:
```lua
{
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "your-colorscheme",
  },
}
```

## 📝 Notes

- LSP servers are managed by Mason (`:Mason` to open)
- Plugins are lazy-loaded for fast startup
- First Neovim launch will take time to install plugins
- Wezterm requires Nerd Font to display icons correctly

## 🔄 Updating

```bash
cd ~/dotfiles
git pull

# Update Neovim plugins
nvim
:Lazy sync

# Update Mason packages
:MasonUpdate
```

## 📄 License

Personal configuration files - feel free to use and modify.
