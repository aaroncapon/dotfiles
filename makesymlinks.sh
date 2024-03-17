#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to and files/folders defined in $FILES
############################

########## Variables

DIR=~/dotfiles                    # dotfiles directory
DIR_OLD=~/dotfiles_old            # old dotfiles backup directory
FILES="bashrc vimrc tmux.conf vim latexmkrc inputrc gdbinit tigrc pylintrc mypy.ini Rprofile"    # list of FILES/folders to symlink in homedir

##########

# Create dotfiles_old in homedir
echo "Creating $DIR_OLD for backup of any existing dotfiles"
mkdir -p $DIR_OLD

# Ensure we're in the dotfiles folder
echo "Changing to the $DIR directory"
cd $DIR || exit

# Move any existing dotfiles in $HOME to dotfiles_old directory, then create symlinks 
for FILE in $FILES; do
  if [ -e "$HOME/.$FILE" ]; then
    echo "Found existing $FILE. Moving to $DIR_OLD"
    mv ~/."$FILE" ~/dotfiles_old/
    echo "  - replacing with symlink"
  else
    echo "Creating symlink for $FILE"
  fi
    ln -s "$DIR/$FILE" ~/."$FILE"
done

## Symlink pip.conf
PIP_CONF="$HOME/.config/pip/pip.conf"
if [ -e "${PIP_CONF}" ]; then
  echo "Found existing pip.conf. Moving to $DIR_OLD"
  mv ~/."${PIP_CONF}" ~/dotfiles_old/
  echo "  - replacing with symlink"
else
  echo "Creating symlink for ${PIP_CONF}"
fi
ln -s "${DIR_FILE}/pip.conf" "${PIP_CONF}"
