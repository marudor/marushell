#!/usr/bin/env bash
OLD="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
git submodule update --init
git config --global core.hooksPath $DIR/githooks
source $DIR/_bootstrapVim.sh
source $DIR/_bootstrapZsh.sh
cd $OLD
