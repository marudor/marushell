#!/usr/bin/env bash

if [ ! -z "$PERFCHECK" ]; then
  zmodload zsh/zprof
fi

export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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

if command -v screen > /dev/null 2>&1; then
  screen -S updateMarushell -d -m "$HOME/.marushell/.checkForUpdate.sh"
else
  echo "Checking for update in Background. Install screen to supress this message!"
  "$HOME/.marushell/.checkForUpdate.sh" &> /dev/null &
  disown
fi

autoload -Uz compinit && compinit -C

if [ -z "$HISTFILE" ]; then
  if [ ! -d "$HOME/.history" ]; then
    mkdir "$HOME/.history"
  fi
  HISTFILE=$HOME/.history/.zsh_history_$(basename tty)
fi

HISTSIZE=10000


alias grep='grep --color'
export GREP_COLOR='3;33'
if command -v most &> /dev/null; then
  export PAGER='most'
fi

export EDITOR='vim'

if [[ -f "/etc/profile" ]]; then
    source "/etc/profile"
fi

if [[ -f "$HOME/.gh_api_token" ]]; then
  HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.gh_api_token)
  export HOMEBREW_GITHUB_API_TOKEN
fi

# shellcheck disable=1090
source "$HOME/.marushell/themeConfig"
if [ -f "$HOME/.themeConfig" ]; then
  # shellcheck disable=1090
  source "$HOME/.themeConfig"
fi

export ZSH_CUSTOM=$HOME/.marushell/custom

# shellcheck disable=1090
source "$HOME/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen oh-my-zsh lib/key-bindings.zshpre
  zgen oh-my-zsh lib/completion.zsh
  zgen oh-my-zsh lib/directories.zsh
  zgen oh-my-zsh lib/theme-and-appearance.zsh
  zgen oh-my-zsh lib/termsupport.zsh
  zgen oh-my-zsh plugins/sudo
  zgen oh-my-zsh plugins/git
  zgen load bhilburn/powerlevel9k powerlevel9k
  zgen load horosgrisa/autoenv
  if command -v pipenv > /dev/null 2>&1; then
    zgen load owenstranathan/pipenv.zsh
  fi

  zgen load zsh-users/zsh-completions src
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting

  zgen load "$ZSH_CUSTOM/plugins/yarn-autocompletions/yarn-autocompletions.plugin.zsh"


  zgen save
fi

lazy_source () {
  eval "$1 () { [ -f $2 ] && source $2 && $1 \$@ }"
}

if command -v hub > /dev/null 2>&1; then
  alias git="hub"
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  # shellcheck disable=1090
  source "$HOME/.nix-profile/etc/profile.d/nix.sh";
fi

function brewCommandNotFound() {
  if command -v brew > /dev/null 2>&1; then
    if ! brew command command-not-found-init &> /dev/null; then
      brew tap homebrew/command-not-found
    fi
    eval "$(brew command-not-found-init)";
  fi
}

# if command -v brew > /dev/null 2>&1; then
#   zgen load vasyharan/zsh-brew-services
# fi

if command -v fasd > /dev/null 2>&1; then
  eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
fi

if command -v fuck > /dev/null 2>&1; then
  fuck() {
    eval "$(command thefuck --alias)"
    fuck "$@"
  }
fi

if [[ -f "$HOME/.profile" ]]; then
  # shellcheck disable=1090
  source "$HOME/.profile"
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

# shellcheck disable=1090
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

if [[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ]]; then
  # shellcheck disable=1090
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
  nix?() {
    nix-env -qa \* -P | grep -F -i "$1";
  }
  export CPATH=$HOME/.nix-profile/include
  export LIBRARY_PATH=$HOME/.nix-profile/lib
  export CPPFLAGS="-I$HOME/.nix-profile/include"
  export CXXFLAGS="-I$HOME/.nix-profile/include"
  export CFLAGS="-I$HOME/.nix-profile/include"
  export LDFLAGS="-L$HOME/.nix-profile/lib"
fi

export PATH=$PATH:$HOME/.marushell/bin

# shellcheck disable=1090
[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

# added by travis gem
# shellcheck disable=1090
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

if [ -f "$HOME/.nvs/nvs.sh" ]; then
  export NVS_HOME="$HOME/.nvs"
  # shellcheck disable=1090
  source "$NVS_HOME/nvs.sh"
  nvs auto on
  # this cd is due to a bug in nvs
  cd . || return
fi


# shellcheck disable=1090
source "$HOME/.marushell/.aliases.sh"
# shellcheck disable=1090
source "$HOME/.marushell/.functions.sh"

if [[ -f "$HOME/.nvm/nvm.sh" ]]; then
  export NVM_DIR="$HOME/.nvm"
  # shellcheck disable=1090
  source "$NVM_DIR/nvm.sh" --no-use
  DEFAULTVER=$(cat "$NVM_DIR/alias/default")
  ACTUALVER=$(command ls "$NVM_DIR/versions/node" | grep "$DEFAULTVER" | tail -1)
  NVMBASEPATH="$NVM_DIR/versions/node"
  export PATH="$PATH:$NVMBASEPATH/$ACTUALVER/bin"


  autoload -U add-zsh-hook
  load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

if [ -f "${HOME}/perl5" ]; then
  PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
  PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;
fi

[ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc ] && source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
[ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc ] && source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# added by travis gem
[ -f /Users/marudor/.travis/travis.sh ] && source /Users/marudor/.travis/travis.sh

if [[ -s "$HOME/n" ]]; then
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
fi

if [[ -s "$HOME/.nodebrew" ]]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi
# shellcheck disable=1090
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

if [ ! -z "$PERFCHECK" ]; then
  zprof
fi
