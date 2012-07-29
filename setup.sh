#!/bin/bash -i

cd $HOME/.vim

timestamp=$(date "+%Y%m%d_%H%M%S")

# Grab Vundle
git clone git@github.com:gmarik/vundle.git bundle/vundle

if [ $? -ne 0 ]; then
  echo "Git clone failed, bailing out..."
  exit 1;
fi

# Link up!
cd $HOME

for f in vimrc gvimrc; do
  if [ -f ".$f" ]; then
    if [ "$(readlink -n .$f)" == ".vim/$f" ]; then
      echo "$HOME/.$f already links to the right file"
    else
      echo "$HOME/.$f exists, moving to .$f.$timestamp"
      mv .$f .$f.$timestamp
      ln -s .vim/$f .$f
    fi
  else
    ln -s .vim/$f .$f
  fi
done

# Install Bundles
vim +BundleInstall +qall

echo "Done!  Vim is fully configured."

