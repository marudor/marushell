export TERM="xterm-256color"
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

setopt HIST_REDUCE_BLANKS
setopt PROMPT_SUBST
unsetopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
unsetopt inc_append_history
unsetopt share_history

if [ -z "$HISTFILE" ]; then
  if [ ! -d $HOME/.history ]; then
    mkdir $HOME/.history
  fi
  HISTFILE=$HOME/.history/.zsh_history_`basename tty`
fi

HISTSIZE=10000
SAVEHIST=10000

alias grep='grep --color'
export GREP_COLOR='3;33'
if type most > /dev/null; then
  export PAGER='most'
fi

export EDITOR='vim'

if [[ -f "$HOME/.gh_api_token" ]]; then
  export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.gh_api_token)
fi

source $HOME/.marushell/themeConfig
if [ -f "$HOME/.themeConfig" ]; then
  source $HOME/.themeConfig
fi

source $HOME/.zgen/zgen.zsh


if ! zgen saved; then
  zgen oh-my-zsh lib/key-bindings.zsh
  zgen oh-my-zsh lib/completion.zsh
  zgen oh-my-zsh lib/directories.zsh
  zgen oh-my-zsh lib/theme-and-appearance.zsh
  zgen oh-my-zsh lib/termsupport.zsh
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


export NVM_DIR="$HOME/.nvm"
if [[ -f "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh" --no-use
  LASTVERSION=$(nvm_ls | tail -1)
  NVMBASEPATH=$(nvm_version_dir)
  export PATH=$PATH:$NVMBASEPATH/$LASTVERSION/bin
fi

if type hub > /dev/null; then
  alias git="hub"
fi

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  source $HOME/.nix-profile/etc/profile.d/nix.sh; 
fi

if type nix-env > /dev/null; then
  nixUpdate() { nix-env -u --keep-going --leq }
  nix?(){ nix-env -qa \* -P | fgrep -i "$1"; }

  export CPATH=$HOME/.nix-profile/include
  export LIBRARY_PATH=$HOME/.nix-profile/lib
  export CPPFLAGS='-I$HOME/.nix-profile/include'
  export LDFLAGS='-L$HOME/.nix-profile/lib'
fi

function brewCommandNotFound() {
  if type brew > /dev/null; then
    if ! brew command command-not-found-init > /dev/null; then
      brew tap homebrew/command-not-found
    fi
    eval "$(brew command-not-found-init)";
  fi
}

if type brew > /dev/null; then
  zgen load vasyharan/zsh-brew-services
  zpath="$(brew --prefix)/etc/profile.d/z.sh"
  [ -s $zpath ] && source $zpath
fi

if type fuck > /dev/null; then
  eval `thefuck --alias`
fi

if [[ -f "$HOME/.opam/opam-init/init.zsh" ]]; then
  source "$HOME/.opam/opam-init/init.zsh"
fi

if [[ -f "$HOME/.profile" ]] then
  source "$HOME/.profile"
fi

if type opam > /dev/null; then
  eval `opam config env`
fi

bindkey -e
bindkey "^[[H" beginning-of-line    #fn-left
bindkey "^[[F" end-of-line          #fn-right
bindkey "^[[1;2D" backward-word      #shift-left
bindkey "^[[1;2C" forward-word       #shift-right

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt

unsetopt BEEP

alias ducks='du -cks * | sort -rn | head'

YARN_DIR="$HOME/.yarn"
if [[ -f "$YARN_DIR/bin/yarn" ]]; then
  export PATH="$YARN_DIR/bin:$PATH"
fi

source $HOME/.marushell/autocomplete/_yarn

[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
if [[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]]; then
  source $HOME/.nix-profile/etc/profile.d/nix.sh
  nix?() {
    nix-env -qa \* -P | fgrep -i "$1"; 
  }
  export CPATH=$HOME/.nix-profile/include
  export LIBRARY_PATH=$HOME/.nix-profile/lib
  export CPPFLAGS="-I$HOME/.nix-profile/include"
  export CXXFLAGS="-I$HOME/.nix-profile/include"
  export CFLAGS="-I$HOME/.nix-profile/include"
  export LDFLAGS="-L$HOME/.nix-profile/lib"
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias service=$HOME/.marushell/service.sh
fi

export PATH=$PATH:$HOME/.marushell/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

source $HOME/.marushell/.functions.sh
source $HOME/.marushell/.aliases.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then source "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then source "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

if [ -f "${HOME}/perl5" ]; then
  PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
  PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;
fi

