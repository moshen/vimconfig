#!/bin/bash -i


# Bail out on failure
set -e

cd $HOME

timestamp=$(date "+%Y%m%d_%H%M%S")
branch="master"

# Check for Remote flag
if [ "$1" == "-r" ]; then
  echo "Remote setup..."
  shift

  if [ -e ".vim" ]; then
    echo "$HOME/.vim exists, moving to .vim.$timestamp"
    mv .vim .vim.$timestamp
  fi

  git clone git@github.com:moshen/vimconfig.git .vim ||
    { echo "Remote clone failed, bailing out..."; exit 1; }

  echo "
"

elif [ "$1" == "-u" ]; then
  echo "Updating current config..."
  shift

  cd .vim

  # Check for an unclean repo
  { git diff-index --quiet --cached HEAD &&
    git diff-files --quiet; } ||
    { echo "Unclean repo, exiting..."; exit 1; }

  # Get changes from Git!
  git pull origin ||
    { echo "Failed to pull changes, exiting..."; exit 1; }

  # Update Bundles
  vim +BundleInstall +BundleUpdate +qall 2>/dev/null

  exit 0;
fi

if [ "$1" ]; then
  branch=$1
fi

cd .vim

# Grab Vundle
if [ ! -d "bundle/vundle/.git" ]; then
  git clone git@github.com:gmarik/vundle.git bundle/vundle ||
    { echo "Git clone failed, bailing out..."; exit 1; }
fi

git checkout $branch ||
  echo "Git checkout failed, continuing...
  but seriously, check your available branches."

# Link up!
cd $HOME

# Check for readlink on Solaris/BSD
readlink=$(type -p greadlink readlink | head -1)

for f in vimrc gvimrc; do
  if [ -L ".$f" ]; then
    if [ "$readlink" ]; then
      if [ "$($readlink -n .$f)" == ".vim/$f" ]; then
        echo "$HOME/.$f already links to the right file"
        continue
      fi
    fi

    echo "$HOME/.$f exists, moving to .$f.$timestamp"
    mv .$f .$f.$timestamp
    ln -s .vim/$f .$f

  elif [ -e ".$f" ]; then
    echo "$HOME/.$f exists, moving to .$f.$timestamp"
    mv .$f .$f.$timestamp
    ln -s .vim/$f .$f

  else
    ln -s .vim/$f .$f
  fi
done

# Install Bundles
vim +BundleInstall +qall 2>/dev/null

echo "Done!  Vim is fully configured."

exit 0

