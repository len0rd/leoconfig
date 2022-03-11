#!/bin/sh

script_path=$(dirname "$0")

echo "Install other non-helpful stuff"

if [ $1 = "Mac" ]; then
    brew cask install minecraft # yep, thats right
# elif [ $1 = "Linux" ]; then
#     # TODO: idk what other stuff i want here
fi
