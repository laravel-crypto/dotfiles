#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if ! type_exists 'composer'; then
    e_arrow 'Downloading Composer'
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod a+x /usr/local/bin/composer
else
    /usr/local/bin/composer self-update
fi

e_arrow 'Downloading Melody'
curl -LsS http://get.sensiolabs.org/melody.phar -o /usr/local/bin/melody
chmod a+x /usr/local/bin/melody

e_arrow 'Downloading Psysh'
curl -LsS https://git.io/psysh -o /usr/local/bin/psysh
chmod a+x /usr/local/bin/psysh

e_arrow 'Downloading Behat'
curl -LsS https://github.com/Behat/Behat/releases/download/v3.3.0/behat.phar -o /usr/local/bin/behat
chmod a+x /usr/local/bin/behat

e_arrow 'Downloading Symfony Installer'
curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony

e_arrow 'Downloading PHP Code Sniffer'
curl -LsS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs
chmod a+x /usr/local/bin/phpcs

e_arrow 'Downloading PHPCS Fixer'
curl -LsS http://get.sensiolabs.org/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
chmod a+x /usr/local/bin/php-cs-fixer

e_arrow 'Downloading PHPDoc'
curl -LsS http://www.phpdoc.org/phpDocumentor.phar -o /usr/local/bin/phpdoc
chmod a+x /usr/local/bin/phpdoc

e_arrow 'Downloading PHPUnit'
curl -LsS https://phar.phpunit.de/phpunit.phar -o /usr/local/bin/phpunit
chmod a+x /usr/local/bin/phpunit

e_arrow 'Downloading PHP Mess Detector'
curl -LsS http://static.phpmd.org/php/latest/phpmd.phar -o /usr/local/bin/phpmd
chmod a+x /usr/local/bin/phpmd

e_arrow 'Downloading Phing'
curl -LsS http://www.phing.info/get/phing-latest.phar -o /usr/local/bin/phing
chmod a+x /usr/local/bin/phing

e_arrow 'Downloading PHPLoc'
curl -LsS https://phar.phpunit.de/phploc.phar -o /usr/local/bin/phploc
chmod a+x /usr/local/bin/phploc

e_arrow 'Downloading PHP Copy & Paste Detector'
curl -LsS https://phar.phpunit.de/phpcpd.phar -o /usr/local/bin/phpcpd
chmod a+x /usr/local/bin/phpcpd

if [ ! -d $HOME/.config/composer/ ]; then
    mkdir -p $HOME/.config/composer/
fi

if [ ! -f $HOME/.config/composer/composer.json ]; then
    ln -s $HOME/.dotfiles/files/config/composer/composer.json $HOME/.config/composer/composer.json
    ln -s $HOME/.dotfiles/files/config/composer/composer.lock $HOME/.config/composer/composer.lock
fi

/usr/local/bin/composer global install

