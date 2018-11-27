#!/usr/bin/env bash

#VIM
OLD="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir $DIR/vim
rm -rf $HOME/.vim
rm $HOME/.vimrc
ln -s $DIR/vim $HOME/.vim
ln -s $DIR/vimrc $HOME/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall
