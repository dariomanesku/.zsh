# start this before tmux
export TERM=screen-256color

#### this is not working good
# If not running interactively, do not do anything
#[[ $- != *i* ]] && return
#[[ $TERM != "screen" ]] && tmux && exit

# TMUX
# if which tmux 2>&1 >/dev/null; then
#    # if no session is started, start a new session
#    if test -z ${TMUX}; then
#        tmux && exit
#    fi
#    # when quitting tmux, try to attach
#    while test -z ${TMUX}; do
#        tmux attach || break
#    done
#fi

# TMUX
#if which tmux 2>&1 >/dev/null; then
#    #if not inside a tmux session, and if no session is started, start a new session
#    test -z "$TMUX" && (tmux attach || tmux new-session)
#fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dario"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# export ZSH_CUSTOM=$HOME/.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git regex-dirstack vim-interaction)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/plugins/regex-dirstack/regex-dirstack.plugin.zsh
source $HOME/.zsh/plugins/vim-interaction/vim-interaction.plugin.zsh

# Customize to your needs...
if [ `uname` = "GNU/Linux" ]; then
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
export CSCOPE_DB=$HOME/.cindex/cscope.out
fi
export EDITOR=/usr/bin/vim

# set -o vi
bindkey -v
set completition-ignore-case on
set show-all-if-ambiguous on

# > in case edit-command-line doesn't work, uncomment this
# autoload -z edit-command-line
# zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey '^[[Z' reverse-menu-complete

# enable ctrl-p/n for history search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -M vicmd "^n" history-beginning-search-backward-end
bindkey -M vicmd "^p" history-beginning-search-forward-end
bindkey -M viins "^n" history-beginning-search-backward-end
bindkey -M viins "^p" history-beginning-search-forward-end

# enable incremental search in vi mode
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

#aliases
alias mv='nocorrect mv'
#alias ls='ls --color=tty -GF'
alias ack='ack-grep'
alias lsx='ls -XF'
alias lsi='ls++ -F'
alias lsia='ls++ -aF'
alias lsix='ls++ -XF'
alias lscolorsdefault='eval $(dircolors -p | dircolors)'
alias lscolorsextended='eval $(dircolors -b $HOME/.dircolors)'
alias githh='git log -n 1 --pretty=format:'%h''
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias ts='tmux switch-client -t'
function tm() { tmux move-window -s $1 -t $2}
alias tm='sh ~/.zsh/.tmux_move_window.sh'
alias uw='echo "URxvt.background : #ffffff" | xrdb -screen'
alias ub='echo "URxvt.background : #1c1c1c" | xrdb -screen'
alias vals='valgrind --tool=memcheck --leak-check=full --show-reachable=yes --num-callers=20 --track-fds=yes'
alias val='valgrind --tool=memcheck --leak-check=full'
alias irc='dtach -A /tmp/dtach.irc -z -r winch zsh'
alias tmux='tmux -2'


#shortcuts #temp
if [ `uname` = "Linux" ]; then
    alias lin='cd /mnt/.systems/lin_hdd/'
    alias linh='cd /mnt/.systems/lin_hdd/home/instructor/'
    alias cppbooks='cd /mnt/storage_hdd1/instructor/CppBooks/'
fi

#Colored ManPages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#testing some stuff:
unsetopt correct_all
unsetopt nomatch

# make cd=pushd
setopt AUTO_PUSHD

#---------------------
# TEST opts
#---------------------
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

setopt PUSHD_TO_HOME
setopt PUSHD_SILENT
setopt PUSHD_IGNORE_DUPS

#10 second wait if you do something that will delete everything...  NO!
#setopt RM_STAR_WAIT

#probably disables ctrl-s
setopt NO_FLOW_CONTROL

# beeps are annoying
setopt NO_BEEP

# Keep echo "station" > station from clobbering station
setopt NO_CLOBBER

# Case insensitive globbing
setopt NO_CASE_GLOB

# Be Reasonable!
setopt NUMERIC_GLOB_SORT

# I don't know why I never set this before.
setopt EXTENDED_GLOB

# hows about arrays be awesome?  (that is, frew${cool}frew has frew surrounding all the variables, not just first and last
setopt RC_EXPAND_PARAM

#TEST do i want this?
unsetopt LIST_AMBIGUOUS
setopt COMPLETE_IN_WORD

#--------------------- 

#TEST
#-----
setopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY
alias lh='fc -RI' #load shared history
#-----

## Be 8 bit clean.
#set meta-flag on
#set input-meta on
#set output-meta on
#set convert-meta off
#
## mode in everything that uses readline
#set editing-mode vi
#set keymap vi

bindkey -M viins '^x^f' complete-word

#for tmux to open new window in current dir. 
TMUX_PWD_COMMAND='$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I") $PWD)'
PS1=$TMUX_PWD_COMMAND$PS1

setopt pushd_silent #Do not print the directory stack after pushd or popd.
setopt ignoreeof #Forces the user to type exit or logout, instead of just pressing ^D.
setopt extendedglob #If the EXTENDEDGLOB option is set, some new features are activated. For example, the ^ character negates the pattern following it
setopt numeric_glob_sort #Use numeric sort instead of alphabetic sort.

#custom stuff:
#disable ctrl+s to freeze and ctrl+q to unfreeze terminal output
stty -ixon

export LD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/lib64

export CL_LOG_ERRORS="stdout"

# export MANPAGER="col -b | vim -c 'set ft=man ts=8 nomod nolist nonu' -c 'nnoremap i <nop>' -" #NOT WORKING


#--------------------------------------------------------
# VIM SERVER ID
#   Always start vim with unique servername.
#--------------------------------------------------------
VIM_SERVER_ID_FILE=$HOME/.vim_server_id

vs_resetCounter()
{
    rm "$VIM_SERVER_ID_FILE"
    echo "0" > "$VIM_SERVER_ID_FILE"
}

vs_setCounterVal()
{
    if [ ! -f "$VIM_SERVER_ID_FILE" ]; then
        echo "0" > "$VIM_SERVER_ID_FILE"
    fi
    sed -i 's/.*/'$value'/' "$VIM_SERVER_ID_FILE"
}

vs_incrementCounter()
{
    if [ ! -f "$VIM_SERVER_ID_FILE" ]; then
        echo "0" > "$VIM_SERVER_ID_FILE"
    fi

    serverlist=$($VIM --serverlist 2>/dev/null)
    value=$(<"$VIM_SERVER_ID_FILE")
    ((value++))
    found=true
    while $found; do
        echo $serverlist | while read x; do
            if [[ "$x" == "$value" ]]; then
                ((value++))
                found=true
                break
            fi
        done
        found=false
    done
    sed -i 's/.*/'$value'/' "$VIM_SERVER_ID_FILE"
}
#not sure overriding vim is good idea. choose another name?
VIM=$(which vim)
alias vi=$VIM
alias vim='vs_incrementCounter && vim --servername $(<"$VIM_SERVER_ID_FILE")'
alias vrs='vs_resetCounter'

function ve() 
{ 
    if ! [[ "$1" =~ ^[0-9]+$ ]] ; then
        #not a number
        serverlist=$($VIM --serverlist 2>/dev/null)
        echo $serverlist | read first
        $VIM --servername $first --remote $1 
    else
        $VIM --servername $1 --remote $2 
    fi
}

#code smell (duplicate)... no time to deal with it.
function vt() 
{ 
    if ! [[ "$1" =~ ^[0-9]+$ ]] ; then
        #not a number
        serverlist=$($VIM --serverlist 2>/dev/null)
        echo $serverlist | read first
        $VIM --servername $first --remote-tab $1 
    else
        $VIM --servername $1 --remote-tab $2 
    fi
}
#--------------------------------------------------------

#test:
alias make='make -j 4' #give it speed !
