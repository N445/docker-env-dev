# System-wide .bashrc file for interactive bash(1) shells.


# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# cration des couleurs avec le generateur a cette adresse : http://bashrcgenerator.com/
if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then
    export PS1="\[$(tput bold)\]\[\033[38;5;226m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;208m\]\\$\[$(tput sgr0)\]\[\033[38;5;10m\]\w\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;11m\]:\[$(tput sgr0)\]"
fi


# enable bash completion in interactive shells
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi


# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
    function command_not_found_handle {
        # check because c-n-f could've been removed in the meantime
        if [ -x /usr/lib/command-not-found ]; then
           /usr/lib/command-not-found -- "$1"
           return $?
        elif [ -x /usr/share/command-not-found/command-not-found ]; then
           /usr/share/command-not-found/command-not-found -- "$1"
           return $?
        else
           printf "%s: command not found\n" "$1" >&2
           return 127
        fi
    }
fi


alias cdwww='cd /data/www && ls -ls'
alias lla='ls -lsa --color=auto'
alias lll='ls -ls --color=auto'
alias ll='ls -l'


alias pbc="php bin/console"
alias pbm="php bin/magento"


alias grep='grep --color=auto'
alias untar='tar -zxvf '


alias ..='cd ..'
alias ...='cd ../../../'

alias k='git add . && git commit -am'


aclit(){
    setfacl -R -m u:www-data:rwX  $1 && setfacl -dR -m u:www-data:rwX $1
}