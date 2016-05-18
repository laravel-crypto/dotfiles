#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

# Install vagrant plugins
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-notify
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-bindfs
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-triggers

# Install vagrant plugins for work machine
vagrant plugin install vagrant-proxyconf

# Patch vagrant notify
curl https://patch-diff.githubusercontent.com/raw/fgrehm/vagrant-notify/pull/22.patch | patch -t -d ~/.vagrant.d/gems/gems/vagrant-notify-0.4.0/lib/vagrant-notify/ plugin.rb

# For some reason 0.6.1 which is in homebrew causes problems with vagrant
curl https://raw.githubusercontent.com/Russell91/sshrc/0.6/sshrc --silent -o /usr/local/bin/vagrant-sshrc
chmod +x /usr/local/bin/vagrant-sshrc

if [ ! -d /etc/sudoers.d/ ]; then
    sudo mkdir /etc/sudoers.d/
fi

sudo touch /etc/sudoers.d/vagrant
sudo sh -c "echo '# Allow Vagrant to manage NFS exports.' > /etc/sudoers.d/vagrant"
sudo sh -c "echo 'Cmnd_Alias VAGRANT_EXPORTS_ADD = $(which tee) -a /etc/exports' >> /etc/sudoers.d/vagrant"
sudo sh -c "echo 'Cmnd_Alias VAGRANT_NFSD = $(which nfsd) restart' >> /etc/sudoers.d/vagrant"
sudo sh -c "echo 'Cmnd_Alias VAGRANT_EXPORTS_REMOVE = $(which sed) -E -e /*/ d -ibak /etc/exports' >> /etc/sudoers.d/vagrant"
sudo sh -c "echo '' >> /etc/sudoers.d/vagrant"
sudo sh -c "echo '# Allow Vagant to manage hosts file.' >> /etc/sudoers.d/vagrant"
sudo sh -c "echo 'Cmnd_Alias VAGRANT_HOSTS_ADD = $(which sh) -c echo \"*\" >> /etc/hosts' >> /etc/sudoers.d/vagrant"
sudo sh -c "echo 'Cmnd_Alias VAGRANT_HOSTS_REMOVE = $(which sed) -i -e /*/ d /etc/hosts' >> /etc/sudoers.d/vagrant"
sudo sh -c "echo '%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE, VAGRANT_HOSTS_ADD, VAGRANT_HOSTS_REMOVE' >> /etc/sudoers.d/vagrant"


# Install homestead & debian
vagrant box add --provider virtualbox laravel/homestead
vagrant box add --provider virtualbox debian/jessie64
vagrant box add --provider virtualbox ubuntu/trusty64

# Hide VirtualBox folder
if [ ! -d $HOME/VirtualBox\ VMs/ ]; then
    mkdir $HOME/VirtualBox\ VMs/
fi

SetFile -a V $HOME/VirtualBox\ VMs/

if [ ! -d $HOME/Vagrant/ ]; then
    mkdir $HOME/Vagrant/
fi
