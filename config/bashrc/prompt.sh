#!/bin/bash

# Adapted from from https://github.com/hoelzro/bashrc/blo...

function __prompt
{
    # List of color variables that bash can use
    local BLACK="\[\033[0;30m\]" # Black
    local DGREY="\[\033[1;30m\]" # Dark Gray
    local RED="\[\033[0;31m\]" # Red
    local LRED="\[\033[1;31m\]" # Light Red
    local GREEN="\[\033[0;32m\]" # Green
    local LGREEN="\[\033[1;32m\]" # Light Green
    local BROWN="\[\033[0;33m\]" # Brown
    local YELLOW="\[\033[1;33m\]" # Yellow
    local BLUE="\[\033[0;34m\]" # Blue
    local LBLUE="\[\033[1;34m\]" # Light Blue
    local PURPLE="\[\033[0;35m\]" # Purple
    local LPURPLE="\[\033[1;35m\]" # Light Purple
    local CYAN="\[\033[0;36m\]" # Cyan
    local LCYAN="\[\033[1;36m\]" # Light Cyan
    local LGREY="\[\033[0;37m\]" # Light Gray
    local WHITE="\[\033[1;37m\]" # White

    local RESET="\[\033[0m\]" # Color reset
    local BOLD="\[\033[;1m\]" # Bold

    local gitdirty
    local svndirty
    local gitbranch
    local svnbranch

    # Look for Git status
    if git status &>/dev/null; then
        if git status -uno -s | grep -q . ; then
            gitdirty=1
        fi
        gitbranch=$(git branch --color=never | sed -ne 's/* //p')
    fi

    # Look for Subversion status
    if svn info &>/dev/null ; then
        svndirty=$(svn status -q)
        wcroot=$(svn info | grep 'Working Copy Root Path:' | grep -o "/.*$")
        svnbranch=$(svn info $wcroot | grep '^URL:' | grep -o '[^/]*$')
    fi

    if [[ (! -z "$gitbranch") && (! -z "$svnbranch") ]]; then
        local git_status_color
        local svn_status_color
        if [[ -z "$gitdirty" ]] ; then
            git_status_color=$LGREEN
        else
            git_status_color=$YELLOW
        fi
        if [[ -z "$svndirty" ]] ; then
            svn_status_color=$LGREEN
        else
            svn_status_color=$YELLOW
        fi
        local git_info
        local svn_info
        git_info="Git: $LCYAN($BOLD$git_status_color$gitbranch$LCYAN)$RESET"
        svn_info="SVN: $LCYAN($BOLD$svn_status_color$svnbranch$LCYAN)$RESET"
        PS1="${git_info}\n${svn_info}\n${debian_chroot:+($debian_chroot)}$LGREEN\h$LBLUE \w $LBLUE\$$RESET "

    else
        local branch
        local dirty
        local vcs_info

        if [[ ! -z "$gitbranch" ]] ; then
            branch=$gitbranch
            dirty=$gitdirty
        elif [[ ! -z "$svnbranch" ]] ; then
            branch=$svnbranch
            dirty=$svndirty
        fi

        if [[ ! -z "$branch" ]]; then
            local status_color
            if [[ -z "$dirty" ]] ; then
                status_color=$LGREEN
            else
                status_color=$YELLOW
            fi
            vcs_info="$LCYAN($BOLD$status_color$branch$LCYAN)"
	else
            vcs_info=
        fi

        PS1="${debian_chroot:+($debian_chroot)}$LGREEN\h$LBLUE:\w${vcs_info}$LBLUE\$$RESET "

    fi
}


if [[ -z "$PROMPT_COMMAND" ]]; then
    PROMPT_COMMAND=__prompt
else
    PROMPT_COMMAND="$PROMPT_COMMAND ; __prompt"
fi
__prompt
