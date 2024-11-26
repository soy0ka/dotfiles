export ZSH="$HOME/.oh-my-zsh"
# export LANG=ko_KR.UTF-8
# export LC_ALL=ko_KR.UTF-8
ZSH_THEME="agnoster"
plugins=(
  git
  # dotenv
  battery
  colorize
  docker 
  docker-compose 
  git-commit
  git-auto-fetch
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

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

# Custom Commands
export PATH=$PATH:$HOME/.scripts/

# Battery
# battery_pct_prompt() {
#   local pct
#   pct=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
#   if [ $pct -lt 20 ]; then
#     echo "%{$fg[red]%} $pct%% %{$reset_color%}"
#   elif [ $pct -lt 50 ]; then
#     echo "%{$fg[yellow]%} $pct%% %{$reset_color%"
#   else
#     echo "%{$fg[green]%} $pct%% %{$reset_color%}"
#   fi
# }
# RPROMPT='$(battery_pct_prompt)'
# BATTERY_CHARGING="⚡️"

# env auto load
if [[ -f "$HOME/.env" ]]; then
  echo "Loading environment variables from $HOME/.env..."
  while IFS='=' read -r key value; do
    # Ignore empty lines or lines starting with #
    if [[ -n "$key" && "$key" != \#* ]]; then
      export "$key"="$value"
    fi
  done < "$HOME/.env"
fi

function auto_activate_venv() {
  if [[ -e .venv/bin/activate ]]; then
    echo "$(.venv/bin/python --version) venv activated "
    source .venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    echo "deactivate venv"
    deactivate
  fi
}

# apply auto_activate_venv when directory changed
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_venv
auto_activate_venv

# homebrew
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:/opt/homebrew/bin"

# multi homebrew setting
if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Java env setting 
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"

# Go Version Manager
[[ -s "/Users/seoyeon/.gvm/scripts/gvm" ]] && source "/Users/seoyeon/.gvm/scripts/gvm"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# pyenv setting
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

# Ruby env
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# Andoroid Studio
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

