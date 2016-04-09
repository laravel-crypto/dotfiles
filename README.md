# dotfiles

This repository contains my system configuration

## Installation

```bash
$ git clone https://github.com/REBELinBLUE/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./setup.sh
```

### Add custom commands

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands, or to add commands you don’t want to commit to a public repository.

For example

```bash
# Git credentials
export GIT_AUTHOR_NAME="Stephen Ball"
export GIT_AUTHOR_EMAIL="stephen@rebelinblue.com"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
```

## Addtional Apps

The following apps need to be installed manually

* BBC iPlayer Downloads
* Clean My Mac 2
* Crashplan
* Firefox
* Google Chrome
* MetaX
* Moneywiz 2
* Things - Out of date version is cask
* WD Access & TPLink PLC Device Scan

Mac appstore apps can be installed with `scripts/mac-appstore.sh`
