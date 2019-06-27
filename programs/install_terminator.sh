#!/bin/bash

sudo add-apt-repository -y ppa:gnome-terminator/ppa
sudo apt-get update
sudo apt-get install -y terminator

mkdir -p ~/.config/terminator

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
cp ${SCRIPTPATH}/../terminator/config ~/.config/terminator/config
