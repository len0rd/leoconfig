#!/bin/sh

if [ $1 = "Mac" ]; then
    echo "Install iterm2"
    brew cask install iterm2
    # TODO: config install?
elif [ $1 = "Linux" ]; then
    echo "install terminator"    
    sudo add-apt-repository -y ppa:gnome-terminator/ppa
    sudo apt-get update
    sudo apt-get install -y terminator

    mkdir -p ~/.config/terminator

    SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
    cp ${SCRIPTPATH}/../configs/terminator/config ~/.config/terminator/config
fi

