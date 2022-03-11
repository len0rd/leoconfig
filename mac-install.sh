#!/bin/sh

script_path=$(dirname "$0")
machine = "Mac"

echo_blue "Install brew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew tap caskroom/cask
echo_green "Brew is setup!"

brew cleanup


echo_blue "Setup SSH config"
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

printf "# General Settings
Host *
  UseKeyChain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa\n" > ssh_config.tmp

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
