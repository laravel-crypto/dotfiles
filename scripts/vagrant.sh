#!/usr/bin/env bash

sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install vagrant plugins
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-notify
vagrant plugin install vagrant-reload

# Patch vagrant notify
curl https://patch-diff.githubusercontent.com/raw/fgrehm/vagrant-notify/pull/22.patch | patch -d ~/.vagrant.d/gems/gems/vagrant-notify-0.4.0/lib/vagrant-notify/ plugin.rb

# Install homestead
vagrant box add --provider virtualbox laravel/homestead

if [ ! -d ~/Vagrant/ ]; then
    mkdir ~/Vagrant/
fi
