#!/bin/sh

script_path=$(dirname "$0")

echo "I'm linux!!!"

echo_red "Work machine? [Y/n]"
read WORK_M

echo_blue "Install all the programs"
$script_path/programs/install-spotify.sh "Linux"
$script_path/programs/install-terminal.sh "Linux"
$script_path/programs/install-vscode.sh "Linux"

# install stuff for a non-work linux machine (fun stuff)
if [ "$WORK_M" == 'n' ]; then
    $script_path/programs/install-messengers.sh "Linux"
fi
echo_green "Programs installed!"