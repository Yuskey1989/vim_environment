#!/bin/sh

# If you have already installed the customized vim environment,
# this setup is interrupted here.
[ `which vim.nox` ] && [ `which git` ] && [ -d ~/.vim/bundle/neobundle.vim ] && exit 0

# Install full version of Vim
sudo apt-get install vim-nox || exit 1
# Install Git
sudo apt-get install git || exit 1

# Copy customized .vimrc to your home directory
cp -i .vimrc ~ || exit 1

# Install vim-plugins
mkdir -p ~/.vim/bundle
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim || exit 1
fi
vim -c NeoBundleInstall
vim -c NeoBundleUpdate

exit 0
