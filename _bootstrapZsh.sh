#!/usr/bin/env bash
#ZSH Plugins
git clone https://github.com/tarjoilija/zgen.git "$HOME/.zgen"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -s "$DIR/zshrc" "$HOME/.zshrc"

if type brew > /dev/null 2>&1; then
  type z > /dev/null 2>&1 || brew install fasd
  type gls > /dev/null 2>&1 || brew install coreutils
  type fzf > /dev/null 2>&1 || brew install fzf
  type pv > /dev/null 2>&1 || brew install pv
  type hub > /dev/null 2>&1 || brew install hub
  type mtr > /dev/null 2>&1 || brew install mtr
  if ! type mtr > /dev/null 2>&1; then
    brew install mtr
    mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/paulirish/.homebrew/Cellar/mtr/0.86`
    sudo chmod 4755 "$mtrlocation/sbin/mtr-packet"
    sudo chown root "$mtrlocation/sbin/mtr-packet"
    sudo chmod u+s "$mtrlocation/sbin/mtr-packet"
  fi
fi

zsh -ic exit
