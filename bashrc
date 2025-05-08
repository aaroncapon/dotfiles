
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups
#HISTTIMEFORMAT="%d/%m/%y %T " ##NOTWORKING!!
# Do not store the following command in history file
export HISTIGNORE="&:clear:exit:GS:git push:git pull:.."
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

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


# Check for colour compatibility
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
else
color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/dotfiles/dircolors && eval "$(dircolors -b ~/dotfiles/dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # Remove bold setting for executables
    LS_COLORS=$LS_COLORS:'ex=0;32:' ; export LS_COLORS
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Type directory name to cd into it
shopt -s autocd
# Enable ** globster 
shopt -s globstar

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cp='cp -i' #Prevent clobbering
alias mv='mv -i' #Prevent clobbering
# Create rsync alias 
alias CP='rsync -ah --progress'

export EDITOR="vim"

# Trim shown directoy in prompt to last three levels
export PROMPT_DIRTRIM=3
# Change date formatting to ISO date format
export TIME_STYLE=long-iso

alias UPDATE='sudo apt update && sudo apt upgrade'
alias TARZIP='tar -czvf' #c-create archive, z-compress with gzip, f-specify output name

# Git aliases
alias GLOG="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%ar / %cr)%Creset' --abbrev-commit --date=relative"
alias GS='git status'
alias GA='git add'
alias GC='git commit -v'
alias GPUSH='git push'
alias GPULL='git pull'
# Open all files with merge conflicts
alias GFIX='vim $(git diff --name-only | uniq)'

alias holdmybeer='sudo'

# Add an "alert" alias for long running commands.  Use like so:
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Tmux aliases. Both followed by name of session
alias tmuxnew='tmux new -s'
alias tmuxkill='tmux kill-session -t'

# Load local alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Colourised Man page
export LESS_TERMCAP_mb=$'\E[01;34m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Fuzzy finder (github.com/junegunn/fzf.vim)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Bash-insulter (github.com/hkbakke/bash-insulter)
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

# Disable XON/XOFF (Ctrl-S/Ctrl-Q)
stty -ixon

# Function extract for common file formats
function extract {
 if [ -z "$1" ]; then
    # Display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

# Set terminal title
function TITLE(){
  if [ -z "${PS1_BACK}" ]; then
    PS1_BACK="${PS1}"
  fi

  TITLE="\[\e]0;$*\a\]"
  PS1="${PS1_BACK}${TITLE}"
}

# Print command execution time on right of terminal.
# Shamelessly stolen from Chuan Ji with minor edits to output formatting
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#    Copyright (C) 2014-2020 Chuan Ji <chuan@jichu4n.com>                     #
#                                                                             #
#    Licensed under the Apache License, Version 2.0 (the "License");          #
#    you may not use this file except in compliance with the License.         #
#    You may obtain a copy of the License at                                  #
#                                                                             #
#     http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                             #
#    Unless required by applicable law or agreed to in writing, software      #
#    distributed under the License is distributed on an "AS IS" BASIS,        #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
#    See the License for the specific language governing permissions and      #
#    limitations under the License.                                           #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #



# A simple Bash script for printing timing information for each command line
# executed.
#
# For the most up-to-date version, as well as further information and
# installation instructions, please visit the GitHub project page at
#     https://github.com/jichu4n/bash-command-timer



# SETTINGS
# ========
#
# Whether to enable the command timer by default.
#
# To temporarily disable the printing of timing information, type the following
# in a session:
#     BCT_ENABLE=0
# To re-enable:
#     BCT_ENABLE=1
BCT_ENABLE=1

# The color of the output for successful and failed commands respectively.
#
# They should be a color string usable in a VT100 escape sequence (see
# http://en.wikipedia.org/wiki/ANSI_escape_code#Colors), without the
# escape sequence prefix and suffix. For example, bold red would be '1;31'.
#
# The color of the output is set in the function BCTPreCommand
#
# If empty, disable colored output. Set them to empty if your terminal does not
# support VT100 escape sequences.
BCT_SUCCESS_COLOR='1;32'
BCT_ERROR_COLOR='1;91'

# The display format of the current time.
#
# This is a strftime format string (see http://strftime.org/). To tweak the
# display format of the current time, change the following line to your desired
# pattern.
#
# If empty, disables printing of current time.
BCT_TIME_FORMAT='%H:%M'

# Whether to print command timings up to millisecond precision.
#
# If set to 0, will print up to seconds precision.
BCT_MILLIS=0

# Wheter to wrap to the next line if the output string would overlap with
# characters of last command's output
BCT_WRAP=1



# IMPLEMENTATION
# ==============

# BCTTime:
#
# Command to print out the current time in nanoseconds. This is required
# because the "date" command in OS X and BSD do not support the %N sequence.
#
# BCTPrintTime:
#
# Command to print out a timestamp using BCT_TIME_FORMAT. The timestamp should
# be in seconds. This is required because the "date" command in Linux and OS X
# use different arguments to specify the timestamp to print.
if date +'%N' | grep -qv 'N'; then
  BCTTime="date '+%s%N'"
  function BCTPrintTime() {
    date --date="@$1" +"$BCT_TIME_FORMAT"
  }
elif hash gdate 2>/dev/null && gdate +'%N' | grep -qv 'N'; then
  BCTTime="gdate '+%s%N'"
  function BCTPrintTime() {
    gdate --date="@$1" +"$BCT_TIME_FORMAT"
  }
elif hash perl 2>/dev/null; then
  BCTTime="perl -MTime::HiRes -e 'printf(\"%d\",Time::HiRes::time()*1000000000)'"
  function BCTPrintTime() {
    date -r "$1" +"$BCT_TIME_FORMAT"
  }
else
  echo 'No compatible date, gdate or perl commands found, aborting'
  exit 1
fi


# BCTPreCommand is trapped to the DEBUG trap, directly or through bash-preexec.
# The debug trap is invoked before the execution of each command typed by the
# user (once for every command in a composite command) and again before the
# execution of PROMPT_COMMAND after the user's command finishes. Thus, to be
# able to preserve the timestamp before the execution of the first command, we
# set the BCT_AT_PROMPT flag in PROMPT_COMMAND, only set the start time if the
# flag is set and clear it after the first execution.
BCT_AT_PROMPT=1
function BCTPreCommand() {
  local EXIT="$?"
  if [ $EXIT == 0 ]
  then
    # colour for exit without error
    BCT_COLOR=$BCT_SUCCESS_COLOR
  else
    # colour for exit with error
    BCT_COLOR=$BCT_ERROR_COLOR
  fi
  if [ -z "$BCT_AT_PROMPT" ]; then
    return
  fi
  unset BCT_AT_PROMPT
  BCT_COMMAND_START_TIME=$(eval $BCTTime)
}


# Bash will automatically set COLUMNS to the current terminal width.
export COLUMNS


# Flag to prevent printing out the time upon first login.
BCT_FIRST_PROMPT=1
# This is executed before printing out the prompt.
function BCTPostCommand() {
  BCT_AT_PROMPT=1

  if [ -n "$BCT_FIRST_PROMPT" ]; then
    unset BCT_FIRST_PROMPT
    return
  fi

  if [ -z "$BCT_ENABLE" ] || [ $BCT_ENABLE -ne 1 ]; then
    return
  fi

  # BCTTime prints out time in nanoseconds.
  local MSEC=1000000
  local SEC=$(($MSEC * 1000))
  local MIN=$((60 * $SEC))
  local HOUR=$((60 * $MIN))
  local DAY=$((24 * $HOUR))

  local command_start_time=$BCT_COMMAND_START_TIME
  local command_end_time=$(eval $BCTTime)
  local command_time=$(($command_end_time - $command_start_time))
  local num_days=$(($command_time / $DAY))
  local num_hours=$(($command_time % $DAY / $HOUR))
  local num_mins=$(($command_time % $HOUR / $MIN))
  local num_secs=$(($command_time % $MIN / $SEC))
  local num_msecs=$(($command_time % $SEC / $MSEC))
  local time_str=""
  if [ $num_days -gt 0 ]; then
    time_str="${time_str}${num_days}d "
  fi
  if [ $num_hours -gt 0 ]; then
    time_str="${time_str}${num_hours}h "
  fi
  if [ $num_mins -gt 0 ]; then
    time_str="${time_str}${num_mins}m "
  fi
  local num_msecs_pretty=''
  if [ -n "$BCT_MILLIS" ] && [ $BCT_MILLIS -eq 1 ]; then
    local num_msecs_pretty=$(printf '%03d' $num_msecs)
  fi
  time_str="${time_str}${num_secs}s${num_msecs_pretty}"
  now_str=$(BCTPrintTime $(($command_end_time / $SEC)))
  if [ -n "$now_str" ]; then
    local output_str="[$time_str | $now_str]"
  else
    local output_str="[$time_str ]"
  fi
  if [ -n "$BCT_COLOR" ]; then
    local output_str_colored="\033[${BCT_COLOR}m${output_str}\033[0m"
  else
    local output_str_colored="${output_str}"
  fi
  # Trick to make sure the output wraps to the next line if there is not
  # enough room for the string (only when BCT_WRAP == 1)
  if [ -n "$BCT_WRAP" ] && [ $BCT_WRAP -eq 1 ]; then
    # we'll print as many spaces as characters exist in output_str, plus 2
    local wrap_space_prefix="${output_str//?/ }  "
  else
    local wrap_space_prefix=""
  fi

  # Move to the end of the line. This will NOT wrap to the next line
  # unless you have BCT_WRAP == 1
  echo -ne "$wrap_space_prefix\033[${COLUMNS}C"
  # Move back (length of output_str) columns.
  echo -ne "\033[${#output_str}D"
  # Finally, print output.
  echo -e "${output_str_colored}"
}


# Callbacks BCTPreCommand() and BCTPostCommand() can be tied to the `DEBUG` 
# trap and `PROMPT_COMMAND` variable in two ways: 
#   * Directly, which makes the script self-contained but breaks compatibility 
#     with other scripts that use DEBUG/PROMPT_COMMAND,
#   * Through `bash-preexec`, which allows several scripts to tie callbacks to
#     DEBUG/PROMPT_COMMAND, but isn't self contained,
#
# If `bash-preexec` is found on the system, method 1 is used. Else, we fall 
# back to the direct way. 
#
function BCTRegisterCallbacksWithBashPreexec() {
  source "$1"
  preexec_functions+=(BCTPreCommand)
  precmd_functions+=(BCTPostCommand)
}
function BCTRegisterCallbacksDirectly() {
  trap 'BCTPreCommand' DEBUG
  PROMPT_COMMAND='BCTPostCommand'
}
# Case 1: User-supplied path via BASH_PREEXEC_LOCATION
if ! [ -z "$BASH_PREEXEC_LOCATION" ] && [ -f "$BASH_PREEXEC_LOCATION" ]; then
  BCTRegisterCallbacksWithBashPreexec "$BASH_PREEXEC_LOCATION"
# Case 2: Common installation locations
elif [ -f '/usr/share/bash-preexec/bash-preexec.sh' ]; then 
  BCTRegisterCallbacksWithBashPreexec '/usr/share/bash-preexec/bash-preexec.sh'
elif [ -f '~/.bash-preexec.sh' ]; then 
  BCTRegisterCallbacksWithBashPreexec '~/.bash-preexec.sh'
# Case 3: bash-preexec not found
else 
  BCTRegisterCallbacksDirectly
fi
unset -f BCTRegisterCallbacksWithBashPreexec
unset -f BCTRegisterCallbacksDirectly
