#!/usr/bin/env bash

# Grab Vundle
git submodule init
git submodule update

# Install Bundles
vim +BundleInstall +qall

# Link up!
cd $HOME
ln -s .vim/vimrc .vimrc
ln -s .vim/gvimrc .gvimrc

