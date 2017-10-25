Dotfiles
========
This repository includes all of my custom dotfiles and some small root alias/startup 
files. The setup script creates symlinks from your home directory to the files which are
located in `~/dotfiles/`. Any existing dotfiles will be moved to `~\dotfiles_old\`.



Installation
------------

``` bash
git clone git://github.com/aaroncapon/dotfiles ~/dotfiles
cd ~/dotfiles
./makesymlinks.sh
```
