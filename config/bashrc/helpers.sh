# Helper functions

# QOL aliases
RED='\033[0;31m'
YELLOW='\033[33;1m'
GREEN='\033[0;32m'
LIGHT_BLUE='\033[1;34m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'

GREEN_BOLD='\033[1;32m'
LIGHT_BLUE_BOLD='\033[1;34m'
PURPLE_BOLD='\033[1;35m'
NC='\033[0m' # No Color

function echo_red() { 
    echo -e ${RED}$@ ${NC}
}
function echo_yellow() { 
    echo -e ${YELLOW}$@ ${NC}
}
function echo_green() { 
    echo -e ${GREEN}$@ ${NC}
}
function echo_lblue() { 
    echo -e ${LIGHT_BLUE}$@ ${NC}
}
function echo_blue() { 
    echo -e ${BLUE}$@ ${NC}
}
function echo_purple() { 
    echo -e ${PURPLE}$@ ${NC}
}

function delim() {
    printf "${PURPLE}%*s${NC}\n" "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    printf "${RED}%*s${NC}\n" "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    printf "${PURPLE}%*s${NC}\n" "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

noconda() {
    # remove conda/anaconda from the path so you use actual python base install
    export PATH=`echo ${PATH} | awk -v RS=: -v ORS=: '/anaconda3/ {next} {print}'`
}

rosat() {
    # tell you whats up with the ros network
    
    echo -e "${LIGHT_BLUE}ROS_MASTER_URI=" ${ROS_MASTER_URI}
    echo -e "ROS_IP=" ${ROS_IP}
    echo -e "ROS_HOSTNAME=" ${ROS_HOSTNAME} ${NC}
}

tunnel() {
    # make ssh tunneling a little easier. Only allows one tunnel at a time - on port 8123
    if [ $1 = "kill" ]; then
        sudo kill $(ps aux | grep 'ssh -D 8123 -f -C' | awk 'NR==1{print $2}')
    else
        ssh -D 8123 -f -C -q -N $1
        ps aux | grep ssh
    fi
}

function gconf() {
    if [ "$1" == "github" ]; then
        git config user.email "len0rd@users.noreply.github.com"
        git config user.name  "len0rd"
        echo_blue "Set git config to Github user"
    fi
}

# completion for the gconf function
__gconf() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    # add different arguments to this as a space-seperated list
    opts="github"

    if [[ ${cur} == * ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}
complete -F __gconf gconf

function gitdebug() {
    echo_blue "Activate super git debug"
    export GIT_TRACE_PACKET=1
    export GIT_TRACE=1
    export GIT_CURL_VERBOSE=1
}

function nogitdebug() {
    echo_blue "Deactivate super git debug"
    unset GIT_TRACE_PACKET
    unset GIT_TRACE
    unset GIT_CURL_VERBOSE
}

# Search for a given symbol in all static libraries (".a") located in the provided path
# arg1: path
# arg2: symbol
function syminlibs() {
    if [[ $# -ne 2 ]]; then
        echo "Invalid arg count. Usage: syminlibs path/of/libs/to/check symbolLookup" >&2
        return 2
    fi
    find $1 -name \*.elf -exec bash -c "nm --defined-only {} 2>/dev/null | grep $2 && echo {}" \;
}

# max out all cpu cores with arbitrary task. Good for tests that need to be performed under heavy load 
function burncpu() {
    numProc="$(getconf _NPROCESSORS_ONLN)"
    openssl speed -multi ${numProc}
}

# run whatever is passed in until it returns a non-zero exit code
function untilfail() {
    while "$@"; do :; done
}
