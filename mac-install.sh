#!/bin/sh

script_path=$(dirname "$0")

echo "I'm ona Mac!!!"


cd env/color_functions
bash copy_color_functions
cd ../..


echo_blue "Install brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew tap caskroom/cask
echo_green "Brew is setup!"

echo_blue "Install all the programs"
$script_path/programs/install_spotify.sh "Mac"
$script_path/programs/install_utilities.sh "Mac"
$script_path/programs/install_anaconda.sh "Mac"
$script_path/programs/install_terminal.sh "Mac"
$script_path/programs/install_vscode.sh "Mac"
$script_path/programs/install_messengers.sh "Mac"
$script_path/programs/install_firefox.sh "Mac"
$script_path/programs/install_other.sh "Mac"
brew cleanup
echo_green "Programs installed!"

$script_path/env/clone_code.sh

echo_blue "Setup SSH config"
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

sshConfig=$(cat ${script_path}/configs/ssh/config)

printf "# General Settings
Host *
  UseKeyChain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa\n${sshConfig}" > ssh_config.tmp

cp ssh_config.tmp ~/.ssh/config
# setup keys
ssh-keygen -t rsa

# cleanup
rm *.tmp
echo_green "SSH config setup"

echo_blue "Append bash_profile stuff"
cat $script_path/configs/bash/rc_common >> ~/.bash_profile
cat $script_path/configs/bash/rc_mac >> ~/.bash_profile
source ~/.bash_profile
echo_green "bash_profile done!"

echo_green "Donzo"
echo_yellow "Here's a list of programs you still need to install:"
echo "  - Bear (appstore)"
echo "  - Joystick Mapper"
echo "  - Screen-scraper(?)"

echo ""
echo_yellow "And stuff todo:"
echo "  - configure alfred over spotlight"
echo "  - enable paragon-ntfs kernel extension(?)"
echo "  - import postico favorites as needed"
