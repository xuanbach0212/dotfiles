#!/bin/bash

set -e

echo "🚀 Installing dotfiles..."

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Backup existing configs
backup_if_exists() {
  if [ -e "$1" ]; then
    echo -e "${YELLOW}Backing up existing $1 to $1.backup${NC}"
    mv "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
  fi
}

# Create symlink
create_symlink() {
  local source="$1"
  local target="$2"

  if [ -L "$target" ]; then
    echo -e "${YELLOW}Removing existing symlink: $target${NC}"
    rm "$target"
  fi

  echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
  ln -s "$source" "$target"
}

# Ensure directories exist
mkdir -p ~/.config

# Backup existing configs
echo ""
echo "📦 Backing up existing configs..."
backup_if_exists ~/.config/ghostty
backup_if_exists ~/.config/lazygit
backup_if_exists ~/.config/hypr
backup_if_exists ~/.config/kitty
backup_if_exists ~/.config/nvim
backup_if_exists ~/.config/yazi
backup_if_exists ~/.config/waybar
backup_if_exists ~/.config/rofi
backup_if_exists ~/.config/wezterm
backup_if_exists ~/.config/tmux
backup_if_exists ~/.zshrc
backup_if_exists ~/.p10k.zsh
backup_if_exists ~/.tflint.hcl

# Create symlinks
echo ""
echo "🔗 Creating symlinks..."
create_symlink ~/.dotfiles/ghostty ~/.config/ghostty
create_symlink ~/.dotfiles/lazygit ~/.config/lazygit
create_symlink ~/.dotfiles/hypr ~/.config/hypr
create_symlink ~/.dotfiles/kitty ~/.config/kitty
create_symlink ~/.dotfiles/nvim ~/.config/nvim
create_symlink ~/.dotfiles/yazi ~/.config/yazi
create_symlink ~/.dotfiles/wezterm ~/.config/wezterm
create_symlink ~/.dotfiles/tmux ~/.config/tmux
create_symlink ~/.dotfiles/zsh/.zshrc ~/.zshrc
create_symlink ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
create_symlink ~/.dotfiles/tflint/.tflint.hcl ~/.tflint.hcl
create_symlink ~/.dotfiles/waybar ~/.config/waybar
create_symlink ~/.dotfiles/rofi ~/.config/rofi

# local-bin scripts (symlink individually to preserve other ~/.local/bin entries)
mkdir -p ~/.local/bin
for f in ~/.dotfiles/local-bin/*; do
  create_symlink "$f" ~/.local/bin/$(basename "$f")
done

# Git global ignore
mkdir -p ~/.config/git
create_symlink ~/.dotfiles/git/ignore ~/.config/git/ignore

# keyd (requires sudo — config lives in /etc/keyd/)
echo ""
echo "⌨️  Setting up keyd..."
if command -v keyd &>/dev/null; then
  if [ -L /etc/keyd/default.conf ]; then
    sudo rm /etc/keyd/default.conf
  elif [ -f /etc/keyd/default.conf ]; then
    sudo mv /etc/keyd/default.conf /etc/keyd/default.conf.backup.$(date +%Y%m%d_%H%M%S)
  fi
  sudo ln -sf ~/.dotfiles/keyd/default.conf /etc/keyd/default.conf
  sudo systemctl enable --now keyd
  echo -e "${GREEN}Creating symlink: /etc/keyd/default.cfg -> ~/.dotfiles/keyd/default.cfg${NC}"
else
  echo -e "${YELLOW}keyd not installed, skipping. Install with: sudo pacman -S keyd${NC}"
fi

echo ""
echo -e "${GREEN}✅ Dotfiles installed successfully!${NC}"
echo ""
echo "📝 Next steps:"
echo "  1. Install a Nerd Font (recommend: Symbols Nerd Font Mono)"
echo "  2. Open Neovim to install plugins: nvim"
echo "  3. Restart your terminal"
echo ""
echo "🔧 Optional tools:"
echo "  - ripgrep: brew install ripgrep"
echo "  - fd: brew install fd"
echo "  - lazygit: brew install lazygit"
echo "  - yazi: brew install yazi"
