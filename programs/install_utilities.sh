#!/bin/sh

script_path=$(dirname "$0")

echo -n "Install a bunch of crap..."

if [ $1 = "Mac" ]; then
    brew install git # if i somehow dont already have it (prolly do if im running this..)
    brew install htop
    brew install gcc
    brew install cmake
    brew install bash-completion # is this really not installed by default?
    brew install automake
    brew install autoconf
    brew install vim
    brew install wget
    brew cask install transmission
    brew cask install alfred
    brew cask install postico
    brew cask install postman
    brew cask install itsycal
    brew cask install paragon-ntfs
    brew cask install parallels
    brew cask install private-internet-access
# elif [ $1 = "Linux" ]; then
#     # TODO: idk what other utilities i want here
fi

echo_cyan "[DONE]"
