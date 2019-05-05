#!/bin/sh

# figure out what system we're running on
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# if this is the right type of machine, run its corresponding setup
if [ ${machine} = "Mac" ]; then
    script_path=$(dirname "$0")
    $script_path/mac-install.sh
elif [ ${machine} = "Linux" ]; then
    script_path=$(dirname "$0")
    $script_path/linux-install.sh
else 
    echo "Sorry, I dont know how to properly install the dev stuff on your type of machine"
    exit 1
fi