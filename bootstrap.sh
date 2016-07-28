#!/usr/bin/env sh
OLD="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
git submodule update --init
source $DIR/_bootstrapVim.zsh
source $DIR/_bootstrapZsh.zsh
cd $OLD
