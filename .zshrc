# ==============================
# ZSH 기본 설정
# ==============================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(
  git
  docker
  docker-compose
  git-commit
  git-auto-fetch
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# ==============================
# Alias
# ==============================
alias c="clear"
alias a="cd $HOME/Documents/Ai-Projects"
alias d="cd $HOME/Documents"
alias p="cd $HOME/Documents/Projects"
alias z="vi ~/.zshrc"
alias ll="ls -l"
alias la="ls -al"
alias lh="ls -alh"
alias img="chafa"
alias tree="tree -I 'node_modules|.git|dist|build|coverage|.DS_Store'"
alias usage="top -l 1 | grep -E '^(CPU|PhysMem)'"

# ==============================
# PATH
# ==============================
export PATH="$HOME/.scripts:$PATH" # Custom Scripts
export PATH="$HOME/.rvm/bin:$PATH" # rvm
export PATH="/opt/homebrew/bin:$PATH" # Homebrew
export PATH="$HOME/Library/Android/sdk/emulator:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/tools/bin:$HOME/Library/Android/sdk/platform-tools:$PATH"

# ==============================
# Multi Homebrew
# ==============================
if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ==============================
# Java 환경 설정
# ==============================
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

# ==============================
# Node Version Manager (NVM)
# ==============================
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ==============================
# pyenv
# ==============================
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ==============================
# rbenv
# ==============================
if [[ -d "$HOME/.rbenv" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# ==============================
# Android Studio
# ==============================
export ANDROID_HOME="$HOME/Library/Android/sdk"

# ==============================
# Go Version Manager (GVM)
# ==============================
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# ==============================
# VirtualEnv Auto Activate
# ==============================
auto_activate_venv() {
  if [[ -d .venv ]]; then
    if [[ -z "$VIRTUAL_ENV" ]]; then
      echo "$(.venv/bin/python --version) venv activated"
      source .venv/bin/activate
    fi
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    echo "Deactivating venv"
    deactivate
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_venv
auto_activate_venv

# ==============================
# 환경 변수 자동 로드 (.env 파일)
# ==============================
if [[ -f "$HOME/.env" ]]; then
  export $(grep -v '^#' "$HOME/.env" | xargs)
fi

# ==============================
# SDKMAN (Must be the last line)
# ==============================
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
