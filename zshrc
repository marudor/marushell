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
setopt inc_append_history
setopt share_history

if [ -z "$HISTFILE" ]; then
  if [ ! -d $HOME/.history ]; then
    mkdir $HOME/.history
  fi
  HISTFILE=$HOME/.history/.zsh_history_`basename tty`
fi

HISTSIZE=10000
SAVEHIST=10000

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'
export PAGER='most'
export EDITOR='vim'

if [[ -f "$HOME/.gh_api_token" ]]; then
  export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.gh_api_token)
fi

source $HOME/.marushell/themeConfig

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


NVM_DIR=$HOME/.nvm
if [[ -f "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh" --no-use
  LASTVERSION=$(nvm_ls | tail -1)
  NVMBASEPATH=$(nvm_version_dir)
  export PATH=$PATH:$NVMBASEPATH/$LASTVERSION/bin
fi

if type hub > /dev/null; then
  alias git="hub"
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
fi

if [[ -f "$HOME/.opam/opam-init/init.zsh" ]]; then
  source "$HOME/.opam/opam-init/init.zsh"
fi

source $HOME/.profile

bindkey -e
bindkey "^[[H" beginning-of-line    #fn-left
bindkey "^[[F" end-of-line          #fn-right
bindkey "^[[1;2D" backward-word      #shift-left
bindkey "^[[1;2C" forward-word       #shift-right

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=reset-prompt

unsetopt BEEP

alias ducks='du -cks * | sort -rn | head'
