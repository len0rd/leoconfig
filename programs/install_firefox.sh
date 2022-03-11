#!/bin/sh

echo "install browser"

if [ $1 = "Mac" ]; then
    brew cask install firefox
fi
