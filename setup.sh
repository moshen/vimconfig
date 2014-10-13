#!/bin/bash -i

# Bail out on failure
set -e

cd $HOME

timestamp=$(date "+%Y%m%d_%H%M%S")
branch="master"

function print_help {
  echo "Usage:
./setup.sh [-r|-u|-h] [branch]

-r      Remote setup, grabs your Vim config from GitHub
-u      Update Vim config from GitHub and update all Plugins
-h      Print this help
branch  The branch name to checkout after setup.
        Defaults to 'master'. Only works with -r or no options
"

  exit 1;
}

if [ $# -gt 2 ]; then
  echo "Too many args...
"

  print_help
fi

case $1 in
"-r")
  echo "Remote setup..."
  shift

  if [ -e ".vim" ]; then
    echo "$HOME/.vim exists, moving to .vim.$timestamp"
    mv .vim .vim.$timestamp
  fi

  git clone https://github.com/moshen/vimconfig.git .vim ||
    { echo "Remote clone failed, bailing out..."; exit 1; }

  echo "
"
  ;;

"-u")
  echo "Updating current config..."
  shift

  cd .vim

  # Check for an unclean repo
  { git diff-index --quiet --cached HEAD &&
    git diff-files --quiet; } ||
    { echo "Unclean repo, exiting..."; exit 1; }

  # Get changes from Git!
  git pull origin $(git rev-parse --abbrev-ref HEAD)||
    { echo "Failed to pull changes, exiting..."; exit 1; }

  # Update Plugins
  vim +PluginClean! +PluginInstall +PluginUpdate +qall 2>/dev/null

  echo "Done! Your vim config is up-to-date"

  exit 0;
  ;;

"-h")
  print_help
  ;;
"--help")
  print_help
  ;;
esac

if [ "$1" ]; then
  branch=$1
fi

cd .vim

# Grab Vundle
git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim ||
  { echo "Failed to clone Vundle.

If you're trying to update, use the -u flag!"; exit 1; }

git checkout $branch ||
  echo "Git checkout failed, continuing...
  but seriously, check your available branches.
"

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

# Install Plugins
echo "" | vim +PluginInstall +qall - ||
  { echo "Vim exited with $?, you may need to check your config."; exit 1; }

echo "Done!  Vim is fully configured."

exit 0

