#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install composer
if ! type_exists 'composer'; then
    e_arrow 'Installing composer'
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer
fi

# Hide VirtualBox folder
if [ ! -d $HOME/VirtualBox\ VMs/ ]; then
    mkdir $HOME/VirtualBox\ VMs/
fi

SetFile -a V $HOME/VirtualBox\ VMs/

# Install glances
sudo chown -R $(whoami) /usr/local
pip install bottle pysnmp zeroconf netifaces influxdb statsd matplotlib pystache py-cpuinfo glances

# Install HTTPie plugins
sudo chown -R $(whoami) /usr/local
pip install --upgrade pip
sudo chown -R $(whoami) /usr/local
pip install httpie-oauth
pip install httpie-jwt-auth

# Install additional CLIs
cp $HOME/.dotfiles/bin/notify-send /usr/local/bin/notify-send
ln -s `which ffmpeg` /usr/local/bin/ffmpeg-static

chmod +x /usr/local/bin/notify-send
chmod +x /usr/local/bin/ffmpeg-static
