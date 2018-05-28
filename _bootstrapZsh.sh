#!/usr/bin/env bash
#ZSH Plugins
git clone https://github.com/tarjoilija/zgen.git "$HOME/.zgen"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -s "$DIR/zshrc" "$HOME/.zshrc"

if type brew 2> /dev/null; then
  type z 2> /dev/null || brew install fasd
  type gls 2> /dev/null || brew install coreutils
  type fzf 2> /dev/null || brew install fzf
  type pv 2> /dev/null || brew install pv
  type hub 2> /dev/null || brew install hub
  if ! type mtr 2> /dev/null; then
    brew install mtr
    mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/paulirish/.homebrew/Cellar/mtr/0.86`
    sudo chmod 4755 "$mtrlocation/sbin/mtr"
    sudo chown root "$mtrlocation/sbin/mtr"
  fi
fi

zsh -ic exit
