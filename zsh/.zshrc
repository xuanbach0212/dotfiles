# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# OS Detection
# ------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  IS_MAC=1
elif [[ -n "$WSL_DISTRO_NAME" || "$(uname -r)" == *microsoft* ]]; then
  IS_WSL=1
  IS_LINUX=1
else
  IS_LINUX=1
fi

# NVM (Node Version Manager)
# ------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
if [[ -n "$IS_MAC" ]]; then
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
fi

# PATH additions
# ------------------------------------------------------------------------------
if [[ -n "$IS_MAC" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="/opt/homebrew/opt/lua/bin:$PATH"
  export PATH="/opt/homebrew/opt/luarocks/bin:$PATH"
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# fzf
# ------------------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# eza (better `ls`)
# ------------------------------------------------------------------------------
if type eza &>/dev/null; then
  alias l="eza --icons=always"
  alias ls="eza --icons=always"
  alias ll="eza -lg --icons=always"
  alias la="eza -lag --icons=always"
  alias lt="eza -lTg --icons=always"
  alias lt2="eza -lTg --level=2 --icons=always"
  alias lt3="eza -lTg --level=3 --icons=always"
  alias lt4="eza -lTg --level=4 --icons=always"
  alias lta="eza -lTag --icons=always"
  alias lta2="eza -lTag --level=2 --icons=always"
  alias lta3="eza -lTag --level=3 --icons=always"
  alias lta4="eza -lTag --level=4 --icons=always"
else
  echo ERROR: eza could not be found. Skip setting up eza aliases.
fi

# zoxide (better `cd`)
# ------------------------------------------------------------------------------
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
else
  echo ERROR: Could not load zoxide shell integration.
fi

# Aliases
# ------------------------------------------------------------------------------
alias n="nvim"

if [[ -n "$IS_MAC" ]]; then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

if [[ -n "$IS_LINUX" ]]; then
  # fd is installed as fdfind on Ubuntu/Debian
  type fdfind &>/dev/null && alias fd="fdfind"
fi

# Git commit with custom date


# GVM (Go Version Manager)
# ------------------------------------------------------------------------------
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
