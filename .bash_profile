# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

##################################################
# Settings for Mac OS X
##################################################
if [ $(uname) = "Darwin" ]; then
    # Homebrew PATH
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
    export MAHPATH=$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman
    # Color settings
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

##################################################
# General Settings
##################################################

### PATH
export PATH=~/bin:$PATH

### Prompt
# k8s (requires kube-ps.sh)
export KUBE_PS1_SYMBOL_DEFAULT="🐳"
source ~/kube-ps1.sh
# git (requires git-prompt.sh)
source ~/git-prompt.sh
# prompt format settings
export PS1='[\u@\h \W $(kube_ps1)$(__git_ps1 "(%s)")]\$ '

### History
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=20000

### Windows Size
# check the window size after each command and, if necessary,
shopt -s checkwinsize

### Pathname Expansion
# "**" matches all files and zero or more directories and subdirectories.
shopt -s globstar

### Colors
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

### Aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

### bash-completion
[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -f /etc/bash_completion ] && . /etc/bash_completion
# Mac OSX(homebrew)
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion


##################################################
# Alias Settings
##################################################
alias tmux='TERM=xterm-256color tmux'


##################################################
# Git Settings
##################################################
if which git &>/dev/null; then
    git config --global user.name "yoichiwo7"
    git config --global user.email "yoichiwo7@gmail.com"
    git config --global color.ui auto
    git config --global core.excludesfile ~/.gitignore
    git config --global core.autocrlf false
    git config --global core.editor vim
fi
