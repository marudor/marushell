#!/usr/bin/env bash

#VIM
OLD="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR git submodule update --init
cd $OLD
rm -rf $HOME/.vim
rm $HOME/.vimrc
ln -s $DIR/vim $HOME/.vim
ln -s $DIR/vimrc $HOME/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
