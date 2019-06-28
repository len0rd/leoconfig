#!/bin/sh

script_path=$(dirname "$0")

echo "install discord and slack"

if [ $1 = "Mac" ]; then
    brew cask install discord
    brew cask install slack
elif [ $1 = "Linux" ]; then
    sudo snap install discord
    sudo snap install slack --classic
fi
