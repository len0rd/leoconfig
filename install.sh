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

script_path=$(dirname "$0")
sudo cp -a $script_path/env/color_functions/. /usr/local/bin/
echo_green "color functions installed"

if [ ${machine} = "Mac" ]; then
    echo "Im ona Mac!"
    # Mac specific setups
    $script_path/mac-install.sh
elif [ ${machine} = "Linux" ]; then
    echo "Im ona Linux!"
    # Linux specific setups
    $script_path/linux-install.sh
else 
    echo "Sorry, I dont know how to properly install the dev stuff on your type of machine"
    exit 1
fi

$script_path/env/install_fonts.sh ${machine}

echo_blue "Install all the programs"
$script_path/programs/install_spotify.sh ${machine}
$script_path/programs/install_utilities.sh ${machine}
$script_path/programs/install_anaconda.sh ${machine}
$script_path/programs/install_terminal.sh ${machine}
$script_path/programs/install_vscode.sh ${machine}
$script_path/programs/install_messengers.sh ${machine}
$script_path/programs/install_firefox.sh ${machine}
$script_path/programs/install_other.sh ${machine}
echo_green "Programs installed!"

echo_blue "Setup Code"
cp $script_path/configs/git/config ~/.gitconfig
cp $script_path/configs/git/excludes ~/.gitexcludes
git config --global user.name "len0rd" # default to github username
$script_path/env/clone_code.sh
echo_green "Code setup"
