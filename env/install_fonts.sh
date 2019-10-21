#!/bin/sh

script_path=$(dirname "$0")

echo -n "Install good fonts..."

if [ $# = "0" ]; then
    echo_red "[ERROR]"
    exit 1
fi

if [ $1 = "Mac" ]; then
    brew tap -q homebrew/cask-fonts
    brew cask install font-fira-code

    git clone -q https://github.com/powerline/fonts.git --depth=1 ${script_path}/fonts
    cd ${script_path}/fonts
    ./install.sh
    cd ..
    rm -rf ${script_path}/fonts
elif [ $1 = "Linux" ]; then
    sudo add-apt-repository universe
    sudo apt -qq update
    sudo apt -qq install fonts-firacode
    sudo apt -qq install fonts-powerline
fi

echo_cyan "[DONE]"
