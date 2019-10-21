#!/bin/sh

script_path=$(dirname "$0")

echo -n "Install ssh config..."

if [ $# = "0" ]; then
    echo_red "[ERROR]"
    exit 1
fi

sshConfig=$(cat ${script_path}/configs/ssh/config)

if [ $1 = "Mac" ]; then
    printf "# General Settings
Host *
   UseKeyChain yes
   AddKeysToAgent yes
   IdentityFile ~/.ssh/id_rsa\n${sshConfig}" > ssh_config.tmp
elif [ $1 = "Linux" ]; then
    ${sshConfig} > ssh_config.tmp
fi

cp ssh_config.tmp ~/.ssh/config
ssh-keygen -t rsa

# cleanup if necessary
rm *.tmp
echo_cyan "[DONE]"
