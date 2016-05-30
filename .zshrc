fpath=(~/.marushell/autocomplete/ $fpath)

source ~/.marushell/antigen.zsh
antigen use oh-my-zsh
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
antigen bundles << EOBUNDLES
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


