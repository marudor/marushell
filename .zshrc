export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8


unsetopt sharehistory

fpath=(~/.marushell/autocomplete/ $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

source ~/.marushell/antigen.zsh
antigen use oh-my-zsh
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

source ~/.marushell/themeConfig
source ~/.profile

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export NVM_DIR="/Users/$(whoami)/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# OPAM configuration
PATH="/Users/tcn/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/tcn/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/tcn/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/tcn/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/tcn/perl5"; export PERL_MM_OPT;


unsetopt inc_append_history
unsetopt share_history

antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply
