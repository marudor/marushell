export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

unsetopt sharehistory
unsetopt share_history
setopt inc_append_history

source $HOME/.marushell/themeConfig

source $HOME/.zgen/zgen.zsh


if ! zgen saved; then
  zgen oh-my-zsh lib/completion.zsh
  zgen oh-my-zsh lib/directories.zsh
  zgen oh-my-zsh lib/theme-and-appearance.zsh
  zgen oh-my-zsh plugins/sudo
  zgen load bhilburn/powerlevel9k powerlevel9k
  zgen load horosgrisa/autoenv
  zgen load caarlos0/zsh-pg


  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting

  zgen save
fi

lazy_source () {
  eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}


NVM_DIR=$HOME/.nvm
if [[ -f "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh" --no-use
  LASTVERSION=$(nvm_ls | tail -1)
  NVMBASEPATH=$(nvm_version_dir)
  export PATH=$PATH:$NVMBASEPATH/$LASTVERSION/bin
fi

function brewCommandNotFound() {
  if type brew > /dev/null; then
    if ! brew command command-not-found-init > /dev/null; then
      brew tap homebrew/command-not-found
    fi
    eval "$(brew command-not-found-init)";
  fi
}

if [[ -f "$HOME/.opam/opam-init/init.zsh" ]]; then
  source "$HOME/.opam/opam-init/init.zsh"
fi

source $HOME/.profile

unsetopt BEEP
