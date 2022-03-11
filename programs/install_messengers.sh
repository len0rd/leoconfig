#!/bin/sh

script_path=$(dirname "$0")

echo "install discord"

if [ $1 = "Mac" ]; then
    brew cask install discord
elif [ $1 = "Linux" ]; then
    sudo snap install discord
fi
