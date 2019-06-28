#!/bin/sh

script_path=$(dirname "$0")

echo "install conda/anaconda"

# TODO: does anaconda have a static link to the latest version?
if [ $1 = "Mac" ]; then
    wget -O conda-inst.sh.tmp https://repo.anaconda.com/archive/Anaconda3-2019.03-MacOSX-x86_64.sh
elif [ $1 = "Linux" ]; then
    sudo snap install discord
    sudo snap install slack --classic
fi
