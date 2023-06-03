
# If not running interactively, dont do anything
case $- in
    *i*) ;;
      *) return;;
esac

# bash history config
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# see man bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# user bin paths
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# User-specific configurations
if [ -d ~/.config/bashrc ]; then
	for rc in ~/.config/bashrc/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

. "$HOME/.cargo/env"
eval "$(starship init bash)"