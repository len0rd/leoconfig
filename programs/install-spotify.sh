#!/bin/sh

script_path=$(dirname "$0")

if [ $1 = "Mac" ]; then
    echo "Downloading the Spotify installer to your Downloads folder"
    wget https://download.scdn.co/SpotifyInstaller.zip -P ~/Downloads
elif [ $1 = "Linux" ]; then
    echo " spotify linux install"
    snap install spotify
fi