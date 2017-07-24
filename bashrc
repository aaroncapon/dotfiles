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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-257color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[1;30m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

##Aliases/exports that are common between all machines
export EDITOR="/usr/bin/vim"
#Trim shown directoy in prompt to last three levels
export PROMPT_DIRTRIM=3

##Change date formatting to ISO date format
export TIME_STYLE=long-iso

alias UPDATE='sudo apt update && sudo apt upgrade'

alias ..='cd ..'
alias cp='cp -i' #Prevent clobbering
alias mv='mv -i' #Prevent clobbering

alias TARZIP='tar -czvf' #c-create archive, z-compress archive with gzip, v-verbose, f-allow name specification of output

#SSH aliases
alias SSHSMI='ssh -X acapon@smilx0.smi.oeaw.ac.at'
alias SFTPSMI='sftp acapon@smilx0.smi.oeaw.ac.at'
alias SSHHEPHY='ssh -X acapon@heplx01.oeaw.ac.at'

alias WEATHER='curl wttr.in/vienna'

#If on work computer
if [ "$HOSTNAME" == "doubleAron" ]; then

    ##Alias to enter ALICE environment
    alias ALIENV_myaliases='cd /home/aaron/alice && alienv --shellrc enter AliPhysics/latest-ali-master'
    alias root='root -l'
    alias BUILDALI='cd ~/alice/ali-master/ && aliBuild -z -w ../sw -d build AliPhysics --disable GEANT3,GEANT4_VMC,fastjet,DPMJET; alert "AliBuild finished"'
    #alias SEARCHALI='. /home/aaron/.scripts/FINDALI.sh'
    alias CDLMEE='cd /home/aaron/alice/ali-master/AliPhysics/PWGDQ/dielectron/'
    alias REWEIGHT='cd /home/aaron/analyses/LHC15g3a3/dataChecks/reweighting/'
    alias LHC16q='cd /home/aaron/analyses/LHC16q/'

    alias BACKUPDOCSlx0='rsync -avzPh --max-size=300M  --delete-after --stats /home/aaron/Documents/ acapon@smilx0.smi.oeaw.ac.at:Documents/'
    alias BACKUPANALYSISlx0='rsync -avzPh --max-size=300M --delete-after --stats --exclude 'LHC16q/QA/trainResults'/home/aaron/analyses/ acapon@smilx0.smi.oeaw.ac.at:analyses/'
    alias SSHGPU='ssh -X aaron@193.170.93.140'
    alias SFTPGPU='sftp aaaron@193.170.93.140'
    alias LATEXMK='TITLESET "LATEXMK" && latexmk -pdf -pvc' #flags to only create pdf and auto update in previewer
    alias GLOG="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%ar / %cr)%Creset' --abbrev-commit --date=relative"
    alias SLEEP="systemctl suspend"
    alias GITHELP="cat ~/.gitCommands"
    alias FIXINTERNET="sudo systemctl restart network-manager.service"

    alias TMUXCHEATSHEET='less ~/.tmux_cheatsheet'

    ##Add path to custom scripts and root
    export PATH=$PATH:/home/aaron/.scripts:


    source /home/aaron/root6/bin/thisroot.sh
    # added by Anaconda2 4.3.1 installer
    export PATH="/home/aaron/anaconda2/bin:$PATH"

    export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] :\w \[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \[\033[00m\] \n\[\033[01;32m\]  ↳\[\033[00m\] ' 
    export WHICHBASH="Work computer bash profile loaded."
#If on home computer
elif [ "$HOSTNAME" == "dubsAron" ]; then

    alias libre='libreoffice 2>/dev/null &'
    alias mydata='libreoffice /home/aaron/.data.ods &'
    alias vless='vim -u /usr/share/vim/vim74/macros/less.vim'
    alias webserver='python -m SimpleHTTPServer'
    alias pi_connect='ssh pi@192.168.0.181'

    ##Add path to custom scripts and root
    export PATH=$PATH:/home/aaron/.scripts:

    export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] :\w \[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \[\033[00m\] \n\[\033[01;32m\]  ↳\[\033[00m\] ' 
    export WHICHBASH="Home computer bash profile loaded."
    
#If on GPU computer
elif [ "$HOSTNAME" == "smiRR-GPU" ]; then
    
    alias root='root -l'
    alias STANDARDENV='source activate standard'
    alias SSHSMI='ssh -X acapon@smilx0.smi.oeaw.ac.at'
    alias SFTPSMI='sftp acapon@smilx0.smi.oeaw.ac.at'
    alias SSHHEPHY='ssh -X acapon@heplx01.oeaw.ac.at'
    alias PID='cd /home/aaron/LHC16q/PID/'
    alias REWEIGHT='cd /home/aaron/LHC16q/covariateReweighting/'
    alias LHC16q='cd LHC16q'

    export PATH=/usr/local/cuda/bin:$PATH
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

    # added by Anaconda2 4.4.0 installer
    export PATH="/home/aaron/anaconda2/bin:$PATH"
    export PS1='\[\033[01;33m\]\u@\h\[\033[01;34m\] :\w \[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \[\033[00m\] \n\[\033[01;32m\]  ↳\[\033[00m\] ' 
    export WHICHBASH="GPU computer bash profile loaded."
fi

#alias VIMTASTIC='SET-TITLE "vim" &&  echo "Title set" && vim'
#Relabel tab name when editing files with vim
function VIM() {
  if [ "$#" == 0 ]; then
    vim
  elif [ "$#" == 1 ]; then
   echo -e "\033]0;${1}\007"
   vim ${1}
   echo -e "\033]0;Terminal\007"
  else
    read -p "Name of tab: " answer
    echo -e "\033]0;${answer}\007"
    vim -O "${@:1}"
    echo -e "\033]0;Terminal\007"
  fi
}

##Function for eog error supression
function EOG() {
	eog "${@}" 2>/dev/null &
}

###Open multiple pdf's sperately and ignore window warnings
function PDF() {
	for FILE in "$@"; do
		evince "$FILE" 2>/dev/null &
	done
}

###Function to supress error warning from eog
function PIC() {
	for FILE in "$@"; do
		eog "$FILE" 2>/dev/null &
	done
}

###Function for examining file type###
function file_type() {
    if [[ -e $1 ]]; then
        echo -e "\nFile type: "
        file $1
        echo -e "\nFile Status: "
        stat $1
    else
        echo "$FUNCNAME: usage: $FUNCNAME file" >&2
        return 1
    fi
}
###Function to rename tab titles
function TITLESET() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

###Open qutebrowser directly to specified ROOT class implementation
function SEARCHROOT() {
    doIt="https://root.cern.ch/doc/master/class$1.html"
    if [[ $# -ge 1 ]]; then
        doIt2="https://root.cern.ch/doc/master/class$2.html"
    fi
    if [[ $# -ge 2 ]]; then
        doIt3="https://root.cern.ch/doc/master/class$3.html"
    fi
    echo "Opening: ${1} ${2} ${3}"
    if [[ $# -eq 1 ]]; then
        qutebrowser ${doIt}
    fi
    if [[ $# -eq 2 ]]; then
        qutebrowser ${doIt} ${doIt2}
    fi
    if [[ $# -eq 3 ]]; then
        qutebrowser ${doIt} ${doIt2} ${doIt3}
    fi
}
     

#### GIT SHIZZLE  #####
##Add git branch to end of prompt. Must have bash-completion installed. See PS1 export below for addition of git addon to PS1 
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
#alias git='hub'
#if [ -f /home/aaron/.hub/etc/hub.bash_completeion.sh ]; then
#  . /home/aaron/.hub/etc/hub.bash_completion.sh
#fi

#Colourised Man page
export LESS_TERMCAP_mb=$'\E[01;34m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

##Stefan's addition for colourised compiling error and warning highlights
make()
{
  pathpat="(/[^/]*)+:[0-9]+"
  ccred=$(echo -e "\033[0;31m")
  ccyellow=$(echo -e "\033[0;33m")
  ccend=$(echo -e "\033[0m")
  /usr/bin/make "$@" 2>&1 | sed -E -e "/[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
  return ${PIPESTATUS[0]}
} 



echo "Did you know that:"; whatis $(ls /bin | shuf -n 1) # | grep '(1)'



#Use solarized directory colours
#eval `dircolors /home/aaron/.dir_colors/dircolors`
