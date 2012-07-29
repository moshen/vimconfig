#!/bin/bash -i

cd $HOME/.vim

# Grab Vundle
git clone git@github.com:gmarik/vundle.git bundle/vundle

# Link up!
cd $HOME
ln -s .vim/vimrc .vimrc
ln -s .vim/gvimrc .gvimrc

# Install Bundles
vim +BundleInstall +qall
