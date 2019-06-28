#!/bin/sh

script_path=$(dirname "$0")

echo "install vscode"

if [ $1 = "Mac" ]; then
    brew cask install visual-studio-code
elif [ $1 = "Linux" ]; then
    sudo snap install code --classic
fi