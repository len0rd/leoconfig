#!/bin/sh

script_path=$(dirname "$0")

echo "install conda/anaconda"

# TODO: does anaconda have a static link to the latest version?
# if [ $1 = "Mac" ]; then
    wget -O ${script_path}/conda-inst.sh.tmp https://repo.anaconda.com/archive/Anaconda3-2019.03-MacOSX-x86_64.sh
    chmod +x ${script_path}/conda-inst.sh.tmp
    sudo bash ${script_path}/conda-inst.sh.tmp # run it
    rm ${script_path}/conda-inst.sh.tmp
# elif [ $1 = "Linux" ]; then
# fi
