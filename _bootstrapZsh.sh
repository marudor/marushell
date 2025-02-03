#!/usr/bin/env bash
#ZSH Plugins
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -s "$DIR/zshrc" "$HOME/.zshrc"
ln -s "$DIR/zimrc" "$HOME/.zimrc"

if type brew > /dev/null 2>&1; then
  brew install kubectl
  type jq > /dev/null 2&>1 || brew install jq
  type z > /dev/null 2>&1 || brew install fasd
  type gls > /dev/null 2>&1 || brew install coreutils
  type fzf > /dev/null 2>&1 || brew install fzf
  type pv > /dev/null 2>&1 || brew install pv
fi

zsh -ic exit
