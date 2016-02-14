#!/bin/sh

# If you have already installed the customized vim environment,
# this setup is interrupted here.
[ `which vim.nox` ] && [ `which git` ] && [ -d ~/.vim/bundle/neobundle.vim ] && exit 0

# Determine package manager
INSTALLER=""
if [ `uname` = "Linux" ]; then
    [ `which apt-get` ] && INSTALLER="apt-get"
    [ `which yum` ] && INSTALLER="yum"
elif [ `uname` = "Darwin" ]; then
    [ `which brew` ] && INSTALLER="brew"
    [ `which port` ] && INSTALLER="port"
fi
[ -n "$INSTALLER" ] || exit 1
# Install full version of Vim and Git
sudo $INSTALLER install vim-nox git || exit 1

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
