#!/bin/sh

script_path=$(dirname "$0")

echo "I'm ona Mac!!!"

sudo cp -a $script_path/env/color_functions/. /usr/local/bin/
echo_green "color functions installed"

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

echo_blue "Setup Code"
cp $script_path/configs/git/config ~/.gitconfig
cp $script_path/configs/git/excludes ~/.gitexcludes
git config --global user.name "len0rd"
git config --global apply.whitespace nowarn
$script_path/env/clone_code.sh
echo_green "Code setup"

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

delim

echo_green "Donzo"
echo_yellow "Here's a list of programs you still need to install:"
echo "  - Bear (appstore)"
echo "  - Joystick Mapper"
echo "  - Private-Internet-Access (installer at /usr/local/Caskroom)"

echo ""
echo_yellow "And stuff todo:"
echo "  - configure alfred over spotlight"
echo "  - enable paragon-ntfs kernel extension(?)"
echo "  - import postico license and favorites as needed"
echo "  - wrap anaconda bash_profile stuff in condainit"
echo "  - import paragon ntfs license"