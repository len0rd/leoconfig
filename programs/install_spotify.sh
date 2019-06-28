#!/bin/sh

script_path=$(dirname "$0")

if [ $1 = "Mac" ]; then
    brew cask install spotify
elif [ $1 = "Linux" ]; then
    echo " spotify linux install"
    sudo snap install spotify
fi