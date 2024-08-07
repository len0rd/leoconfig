# Aliases I like to use

alias ls='ls -GFhlA --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias pssh='ps aux | grep ssh'
alias jj='java -jar'
alias clear='clear && delim'

# git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gpush='git push'
alias gpull='git pull'
alias gcheck='git checkout'
alias gremote='git config --get remote.origin.url'
alias gsub='git submodule update --init --recursive'
# prune away local copies of branches that have been merged on remote
alias gprune='git fetch -p && git branch --merged | grep -i -v -E "master|develop|main|dev" | xargs git branch -d'
alias gdiff='git diff'
# git log with one line per commit and a cute graph
alias glog="git log --branches --remotes --tags --oneline --decorate --graph"

# use neovim
alias vim=nvim

# ssh convenience
# get a list of the host names configured in your ssh for when you forget
alias sshhosts="grep '^Host' ~/.ssh/config"


# fuzzy open/search convenience
alias op="fd --type f --hidden --exclude .git | fzf-tmux -p | xargs code"

# when in a tmux session, apply my default starting layout to the current window
alias deflayout="tmux split-window -h && tmux split-window -v"
