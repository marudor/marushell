#!/usr/bin/env bash
#VIM
OLD="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR git submodule update --init
cd $OLD
ln -s $DIR/vim $HOME/.vim
ln -s $DIR/vimrc $HOME/.vimrc

vim +PluginInstall +qall
