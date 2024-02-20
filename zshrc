# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/usr/bin/env bash

if [ ! -z "$PERFCHECK" ]; then
  zmodload zsh/zprof
fi

if [ ! -d "$HOME/.history" ]; then
  mkdir "$HOME/.history"
fi

HISTSIZE=100000
SAVEHIST=100000

setopt HIST_REDUCE_BLANKS
setopt PROMPT_SUBST
unsetopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt REMATCH_PCRE


setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt no_share_history
unsetopt share_history

export TERM="xterm-256color"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v screen > /dev/null 2>&1; then
  screen -S updateMarushell -d -m "$HOME/.marushell/.checkForUpdate.sh"
else
  echo "Checking for update in Background. Install screen to supress this message!"
  "$HOME/.marushell/.checkForUpdate.sh" &> /dev/null &
  disown
fi

alias grep='grep --color'
export GREP_COLOR='3;33'

export EDITOR='vim'

if [[ -f "/etc/profile" ]]; then
    source "/etc/profile"
fi

if [[ -f "$HOME/.gh_api_token" ]]; then
  HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.gh_api_token)
  export HOMEBREW_GITHUB_API_TOKEN
fi

zgenom () {
	source ${HOME}/.zgenom/zgenom.zsh
	zgenom "$@"
}


if [[ ! -s ${HOME}/.zgenom/sources/init.zsh ]]; then
  zgenom ohmyzsh

  zgenom ohmyzsh plugins/git
  #zgenom ohmyzsh plugins/sudo
  #zgenom ohmyzsh plugins/asdf
  # Install ohmyzsh osx plugin if on macOS
  [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos


  zgenom load romkatv/powerlevel10k powerlevel10k

  
  zgenom load zsh-users/zsh-completions src
  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-syntax-highlighting

  zgenom save

  zgenom compile "$HOME/.zshrc"
else
  source $HOME/.zgenom/sources/init.zsh
fi

python_venv() {
  MYVENV=./venv
  # when you cd into a folder that contains $MYVENV
  [[ -d $MYVENV ]] && source $MYVENV/bin/activate > /dev/null 2>&1
  # when you cd into a folder that doesn't
  [[ ! -d $MYVENV ]] && deactivate > /dev/null 2>&1
}
autoload -U add-zsh-hook
add-zsh-hook chpwd python_venv

python_venv

if command -v hub > /dev/null 2>&1; then
  alias git="hub"
fi

if command -v fasd > /dev/null 2>&1; then
  fasd_cache="$HOME/.fasd-init-zsh"
  if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache
fi

if command -v fuck > /dev/null 2>&1; then
#  eval $(thefuck --alias)
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

export PATH=$PATH:$HOME/.marushell/bin

# shellcheck disable=1090
[ -f "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -f "$HOME/.nvs/nvs.sh" ]; then
  export NVS_HOME="$HOME/.nvs"
  # shellcheck disable=1090
  source "$NVS_HOME/nvs.sh"
  nvs auto on
  if [ -f ".node-version" ] | [ -f ".nvmrc" ]; then
    nvs cd
  fi
fi


# shellcheck disable=1090
source "$HOME/.marushell/.aliases.sh"
# shellcheck disable=1090
source "$HOME/.marushell/.functions.sh"


# Performance issue, once fixed alias
#if command -v lab > /dev/null 2>&1; then
#  alias git="lab"
#fi

if command -v direnv > /dev/null 2>&1; then
  direnv_cache="$HOME/.direnv-init-zsh"
  if [ "$(command -v direnv)" -nt "$direnv_cache" -o ! -s "$direnv_cache" ]; then
    direnv hook zsh >| "$direnv_cache"
  fi
  source "$direnv_cache"
  unset direnv_cache
fi

if command -v bat > /dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.marushell/p10k.zsh ]] || source $HOME/.marushell/p10k.zsh
source $HOME/.marushell/themeConfig


setopt no_share_history
unsetopt share_history

if command -v kubectl > /dev/null 2>&1; then
  kubectl_cache="$HOME/.kubectl-completion-init-zsh"
  if [ "$(command -v kubectl)" -nt "$kubectl_cache" -o ! -s "$kubectl_cache" ]; then
    kubectl completion zsh  | grep -v '^autoload .*compinit$' >| "$kubectl_cache"
  fi
  source $kubectl_cache
  unset kubectl_cache
fi

autoload -Uz compinit && compinit -C

if [ ! -z "$PERFCHECK" ]; then
  zprof
fi

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
