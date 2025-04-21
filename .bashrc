# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# 

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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
#force_color_prompt=yes

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

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt

# Nice Rainbow Prompt
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='\[\e[38;5;201;1m\]\u\[\e[0;38;5;227m\]@\[\e[38;5;45m\]\H\[\e[0m\]|(\[\e[38;5;227m\]${PS1_CMD1}\[\e[0m\])\n\[\e[38;5;195;48;5;53m\][\w\[\e[39m\]]\[\e[0;38;5;227m\]|\[\e[38;5;38m\]\$\[\e[0m\] '
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll="ls -alF"
alias la='ls -A'
alias l='ls -CF'
alias cp="cp -i"    
alias free='free -m'                      # show sizes in MB
alias bat="/home/linuxbrew/.linuxbrew/bin/bat"
alias vim=vi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# MY ENVIRONMENT VARIABLES
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="vim"
export DOTFILES="$HOME/dotfiles"
export SCRATCHPAD="$HOME/scratchpad"
export HOSTNAME="Nezuko"
# Alias definitions.
# You may want to put all your additions into a separate file like
#uu~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# MY ALIAS DEFINITIONS
alias xsc="xclip -selection clipboard"
alias killBT="rfkill block bluetooth"
alias unKillBT="rfkill unblock bluetooth"
# source, and open bashrc easily
alias cb="cat $HOME/.bashrc"
alias eb="vim $HOME/.bashrc"
alias sb="source $HOME/.bashrc"

alias cmx="chmod u+x $1"

# edit i3 config
alias ei3="vim $HOME/.config/i3/config"
# edit tmux config
alias etm="vim $HOME/.tmux.conf"

# open scratch file to try tests or write stuff
alias scratchpad="vim $SCRATCHPAD"

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

# enable vi mode in bash
set -o vi

# enable linuxbrew command
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
xmodmap -e "keycode 66 = Control_L"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# my shell functions
linkDotFile() {
    read -p "dotfile target (e.g: nvm or .bashrc): " target
    if [[ ! -e "$DOTFILES/$target" ]]; then
      echo "target file $target does not exists"
      return 1
    fi
    read -p "link name (e.g .config/nvim or .vimrc): " link


   if [[ -e "$HOME/.screenkey" ]]; then
     if [[ -s "$HOME/$link" ]]; then
       echo "link already exists"
       return 1
     fi
     echo "file already exists"
     return 1
   fi
   ln -s "$DOTFILES/$target" "$HOME/$link"
   echo "successful! $HOME/$link ==> $DOTFILES/$target"
 }

commitDotFiles() {
  pushd $DOTFILES
  git add .
  git commit -m "update dotfiles $(date)"
  git push
  popd
}
startMongo() {
  sudo systemctl start mongod
  sudo systemctl enable mongod
}

addToPath() {
  if [[ "$PATH" != *"$1"* ]]; then
    export PATH=$PATH:$1
  fi
}

addToPathFront() {
  if [[ "$PATH" != *"$1"* ]]; then
    export PATH=$1:$PATH
  fi
}

scratch() {
  read -p "runtime? " runtime
  $runtime $SCRATCHPAD
}

clone() {
  read -p "username? " username
  read -p "repo? " repo
  read -p "destination? " destination
  if [[ $destination == "" ]]; then
    destination="$HOME/Downloads/$repo"
  fi
  git clone "https://github.com/$username/$repo" $destination
}
