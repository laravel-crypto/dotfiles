#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


if [ -f ~/.bashrc ]; then
    rm  ~/.bashrc
fi

ln -s ~/.dotfiles/files/.bashrc ~/.bashrc

if [ -f ~/.bash_profile ]; then
    rm  ~/.bash_profile
fi

ln -s ~/.dotfiles/files/.bash_profile ~/.bash_profile

if [ -f ~/.editorconfig ]; then
    rm  ~/.editorconfig
fi

ln -s ~/.dotfiles/files/.editorconfig ~/.editorconfig

if [ -f ~/.inputrc ]; then
    rm  ~/.inputrc
fi

ln -s ~/.dotfiles/files/.inputrc ~/.inputrc

if [ -f ~/.gitconfig ]; then
    rm  ~/.gitconfig
fi

ln -s ~/.dotfiles/files/.gitconfig ~/.gitconfig

if [ -f ~/.gitignore_global ]; then
    rm  ~/.gitignore_global
fi

ln -s ~/.dotfiles/files/.gitignore_global ~/.gitignore_global

if [ -f ~/.nanorc ]; then
    rm  ~/.nanorc
fi

ln -s ~/.dotfiles/files/.nanorc ~/.nanorc

if [ -f ~/.tvnamer.json ]; then
    rm  ~/.tvnamer.json
fi

ln -s ~/.dotfiles/files/.tvnamer.json ~/.tvnamer.json


source ~/.bashrc
