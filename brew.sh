#!/bin/bash

# Make sure we’re using the latest Homebrew
brew update
# Upgrade any already-installed formulae brew upgrade
# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`
brew install gnu-sed
# pv
brew install pv
# mac utilities
brew install m-cli

# Updated shells
# Note: don’t forget to add `/usr/local/bin/<EACHSHELL>` to `/etc/shells` before running `chsh`.
brew install bash
brew install zsh
brew install fish

brew install bash-completion@2

# Install wget
brew install wget

# Install more recent versions of some OS X tools
brew install nvim
brew install grep
brew install openssh

# run this script when this file changes guy.
brew install entr

# github util
brew install gh
# nicer git diffs
brew install git-delta

# better `top`
brew install glances

brew install shellcheck # linting for .sh files

# mtr - ping & traceroute. best.
brew install mtr

# allow mtr to run without sudo
mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/paulirish/homebrew/Cellar/mtr/0.86`
sudo chmod 4755 $mtrlocation/sbin/mtr
sudo chown root $mtrlocation/sbin/mtr

# Install other useful binaries
brew install the_silver_searcher # ack is an alternative, tbh i forget which i like more.
brew install fzf

brew install imagemagick
brew install node # This installs `npm` too using the recommended installation method
brew install rename
brew install tree
brew install zopfli
brew install ffmpeg
brew install dust
rew install hyperfine
brew install zellij
brew install lsd
brew install lazygit
brew install pre-commit
brew install clang-format
# Nvim
brew install luarocks

brew install youtube-dl

# will probably need these at some point
brew install automake cmake go rust

# install latex stuff
brew install pandoc
brew install graphviz

# install gcc
brew install gcc
brew install llvm

# windows manage

brew install koekeishiya/formulae/skhd
brew install koekeishiya/formulae/yabai

brew tap FelixKratz/formulae
brew install sketchybar
brew install --cask sf-symbols

brew install jq
brew install gh # gh auth cli
brew install switchaudio-osx
brew install ifstat
brew install svim

# latex compiler
brew install tectonic
brew install pstree

brew install ruff

# show unicode text of figure
brew install chafa
brew install translate-shell
brew install aspell

cargo install cbfmt

# update all things
brew install topgrade
brew install just
brew install bottom
brew install himalaya
brew install scc
brew install dooit
brew install onefetch
brew install act
brew tap wtfutil/wtfutil
brew install wtfutil
brew install hub

#To use the bundled libc++ please add the following LDFLAGS:
#  LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"

#llvm is keg-only, which means it was not symlinked into /opt/homebrew,
#because macOS already provides this software and installing another version in
#parallel can cause all kinds of trouble.

#If you need to have llvm first in your PATH, run:
#  fish_add_path /opt/homebrew/opt/llvm/bin

#For compilers to find llvm you may need to set:
#
#  set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
#  set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

# Remove outdated versions from the cellar
brew cleanup
