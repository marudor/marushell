# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
# zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


if [[ -f "/opt/homebrew/bin/brew" ]]; then
  export HOMEBREW_NO_ENV_HINTS=1
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

alias grep='grep --color'
 [[ "$(uname -s)" != Darwin ]] && export GREP_COLOR='mt=3;33'

export EDITOR='vim'
if [[ "$TERM_PROGRAM" =~ "vscode" ]]; then
  export EDITOR='code --wait'
fi
if [[ "$TERM_PROGRAM" =~ "zed" ]]; then
  export EDITOR='zed --wait'
fi

if [[ -f "/etc/profile" ]]; then
    source "/etc/profile"
fi

if [[ -f "$HOME/.gh_api_token" ]]; then
  HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.gh_api_token)
  export HOMEBREW_GITHUB_API_TOKEN
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


bindkey "^[[1;2D" backward-word      #shift-left
bindkey "^[[1;2C" forward-word       #shift-right

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

if command -v hub > /dev/null 2>&1; then
 alias git="hub"
fi


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

if [ ! -z "$PERFCHECK" ]; then
  zprof
fi
