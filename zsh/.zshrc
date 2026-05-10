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

# pyenv (Python version manager - global)
# ------------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Editor
# ------------------------------------------------------------------------------
export EDITOR=nvim
export VISUAL=nvim

# NVM (Node Version Manager) - lazy loaded for faster shell startup
# ------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
# Expose default node binary to PATH so tools like Copilot and pyright can find it
if [[ -d "$NVM_DIR/versions/node" ]]; then
  local _nvm_node=$(ls -t "$NVM_DIR/versions/node" | head -1)
  [[ -n "$_nvm_node" ]] && export PATH="$NVM_DIR/versions/node/$_nvm_node/bin:$PATH"
fi
nvm() {
  unset -f nvm node npm npx yarn
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() {
  unset -f nvm node npm npx yarn
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  node "$@"
}
npm() {
  unset -f nvm node npm npx yarn
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  npm "$@"
}
npx() {
  unset -f nvm node npm npx yarn
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  npx "$@"
}
yarn() {
  unset -f nvm node npm npx yarn
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  yarn "$@"
}

# PATH additions
# ------------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

if [[ -n "$IS_MAC" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="/opt/homebrew/opt/lua/bin:$PATH"
  export PATH="/opt/homebrew/opt/luarocks/bin:$PATH"
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

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

# Aliases
# ------------------------------------------------------------------------------
alias n="nvim"
alias yz="yazi"

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

# zoxide (better `cd`) - must be at end of zshrc
# ------------------------------------------------------------------------------
if type zoxide &>/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
else
  echo ERROR: Could not load zoxide shell integration.
fi

# Wayland
export MOZ_ENABLE_WAYLAND=1
