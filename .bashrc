# ~/.bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;35m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
export PATH=$HOME/.local/bin:$PATH

export PATH="$HOME/.config/emacs/bin:$PATH"

#keychain

eval `keychain --eval id_ed25519`

# find . | fzf
# export FZF_DEFAULT_COMMAND='micro $(find .)'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#aaaaaa,bg:#000000,hl:#aaaaaa --color=fg+:#ba4a16,bg+:#000000,hl+:#ba4a16 --color=info:#ba4a16,prompt:#ba4a16,pointer:#ba4a16 --color=marker:#ba4a16,spinner:#ba4a16,header:#f752cb'

export BAT_THEME="ansi"

alias m="micro"
alias bat="batcat"

alias e="emacs -nw"

function ef() {
    local file=$(find . -type f -not -path '*/.*' | fzf --preview "cat {}")
    [[ -n "$file" ]] && emacs -nw "$file"
}

function efa() {
    local file=$(find . -type f | fzf --preview "cat {}")
    [[ -n "$file" ]] && emacs -nw "$file"
}

function mf() { 
    local file=$(find . -type f -not -path '*/.*' | fzf --preview "cat {}")
    [[ -n "$file" ]] && micro "$file"
}

function mfa() { 
    local file=$(find . -type f | fzf --preview "cat {}")
    [[ -n "$file" ]] && micro "$file"
}


function cf() { cd $(find . -type d -not -path '*/.*' | fzf); }
function cfa() { cd $(find . -type d | fzf); }

function fat() { 
	local file=$(find . -type f -not -path '*/.*' | fzf)
	[[ -n "$file" ]] && batcat "$file"
}

function fatt() { 
	local file=$(find . -type f | fzf)
	[[ -n "$file" ]] && batcat "$file"
}

. "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"

# Emulate an MS-DOS prompt in your Linux shell.
# Laszlo Szathmary (jabba.laci@gmail.com), 2011
# Project home page:
# https://ubuntuincident.wordpress.com/2011/02/08/emulate-the-ms-dos-prompt/
## Zoxide configuration
export _ZO_ECHO=1
export _ZO_RESOLVE_SYMLINKS=1
export _ZO_EXCLUDE_DIRS="$HOME/.cache:$HOME/.git"

# Initialize zoxide - creates the main 'z' command
eval "$(zoxide init bash)"

# Aliases that accept arguments
alias za='zoxide add'                   # Manually add current directory
alias zr='zoxide remove'                # Remove directory from database

eval "$(zoxide init bash)"

# function z() {
#     local dir=$(zoxide query "$@")
#     [[ -n "$dir" ]] && cd "$dir"
# }

# function zi() {
#     local dir=$(zoxide query --interactive "$@")
#     [[ -n "$dir" ]] && cd "$dir"
# }

# function zq() {
#     zoxide query "$@"
# }

alias kbs="xset r rate 150 50 && setxkbmap -option caps:ctrl_modifier"
alias ubt="cp -a ~/code/_unity_template/. ."

source "$HOME/code/dotbackup/backup.sh"

alias bud="backup_from_list"
alias atb="add_to_backup_list"
alias rfb="remove_from_backup_list"

alias gpt="sgpt --temperature 1"
alias gptc="sgpt --temperature 1 --chat"

alias x41pkg='sudo docker run -it --rm --platform linux/386 -v ~/x41-debs:/debs debian:12'
