#!/bin/sh

script_path=$(dirname "$0")

echo "install a bunch of crap"

if [ $1 = "Mac" ]; then
    brew install htop
    brew install gcc
    brew install cmake
    brew install bash-completion # is this really not installed by default?
    brew install automake
    brew install autoconf
elif [ $1 = "Linux" ]; then
    # TODO: idk what other utilities i want here
fi
