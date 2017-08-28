#!/bin/sh

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
# Install Vim and Git
sudo $INSTALLER install vim git || exit 1
# Install Vim full version
if [ ! `which vim.nox` ]; then
    echo -n "Do you want to install vim full version? [Y/n] : "
    read answer
    case "$answer" in
	N | n | No | no)
	    echo "Continue..." ;;
	*)
	    sudo $INSTALLER install vim-nox ;;
    esac
fi
# If you have already installed the customized vim environment,
# this setup is interrupted here.
[ `which vim` ] && [ `which git` ] && [ -d ~/.vim/bundle/repos/github.com/Shougo/dein.vim ] && exit 0

# Copy customized .vimrc to your home directory
cp -i .vimrc ~ || exit 1

# Install vim-plugins
if [ ! -d ~/.vim/bundle/repos/github.com/Shougo/dein.vim ]; then
    mkdir -p ~/.vim/bundle/repos/github.com/Shougo/dein.vim
    git clone https://github.com/Shougo/dein.vim ~/.vim/bundle/repos/github.com/Shougo/dein.vim || exit 1
fi
vim -c 'call dein#install()'
vim -c 'call dein#update()'

exit 0
