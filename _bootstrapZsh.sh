#!/usr/bin/env sh
#ZSH Plugins
git clone https://github.com/tarjoilija/zgen.git $HOME/.zgen
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -s $DIR/zshrc $HOME/.zshrc
