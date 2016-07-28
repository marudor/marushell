#!/usr/bin/env sh
#VIM
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -s $DIR/vim $HOME/.vim
ln -s $DIR/vimrc $HOME/.vimrc

vim +PluginInstall +qall
