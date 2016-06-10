export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8


unsetopt sharehistory

fpath=(~/.marushell/autocomplete/ $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

source ~/.marushell/antigen.zsh
antigen use oh-my-zsh
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
antigen bundles << EOBUNDLES
  thefuck
  git
  zsh-users/zsh-syntax-highlighting
  command-not-found
  Tarrasch/zsh-autoenv
  colorize
  git-flow
  github
  history
  node
  npm
  nvm
  postgres
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
EOBUNDLES


AUTOENV_FILE_ENTER=.env


if [[ $CURRENT_OS == 'OS X' ]]; then
    antigen bundle brew
    antigen bundle osx
elif [[ $CURRENT_OS == 'Linux' ]]; then
    if [[ $DISTRO == 'CentOS' ]]; then
        antigen bundle centos
    fi
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
    antigen bundle cygwin
fi


antigen apply


BULLETTRAIN_GIT_COLORIZE_DIRTY=true
BULLETTRAIN_RUBY_SHOW=false
BULLETTRAIN_IS_SSH_CLIENT=true



source ~/.profile

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/marudor/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# OPAM configuration
. /Users/marudor/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
