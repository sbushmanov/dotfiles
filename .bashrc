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
HISTSIZE=100000
HISTFILESIZE=500000

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*|alacritty)
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
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

#CUDA start
export CUDA_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
export JOBLIB_START_METHOD=forkserver
export CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda
#CUDA end

# SPARK START
export SPARK_HOME="/home/sergey/spark"
export PATH=$SPARK_HOME/bin:$PATH
# SPARK END

#HADOOP START
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/home/sergey/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_CONFIG_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
export LD_LIBRARY_PATH=/home/sergey/hadoop/lib/native/:/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
#HADOOP END

#HIVE start
export HIVE_HOME=/home/sergey/hive
export HIVE_CONF_DIR=/home/sergey/hive/conf
export PATH=$PATH:$HIVE_HOME/bin
export CLASSPATH=$CLASSPATH:/home/sergey/hadoop/lib/*:.
export CLASSPATH=$CLASSPATH:/home/sergey/hive/lib/*:.
export PATH=$PATH:$HIVE_HOME/hcatalog/bin
#HIVE end

#PRESTO start
alias presto='presto-server-332/bin/launcher run'
#PRESTO end

# DRILL start
#export DRILL_HOME=/home/sergey/apache-drill
#alias drill='/home/sergey/apache-drill/bin/drill-embedded'
alias drill='env -i HOME="$HOME" LC_CTYPE="${LC_ALL:-${LC_CTYPE:-$LANG}}" PATH="$PATH" USER="$USER" /home/sergey/apache-drill-1.17.0/bin/drill-embedded'
# DRILL end

#setxkbmap -model pc105 -layout "us,ru" -option "grp:alt_shift_toggle,grp_led:scroll"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/opt/mssql-tools/bin"

#STARSPACE Start
export PATH="$PATH:/home/sergey/Starspace"
#STARSPACE End

export PATH="$PATH:/opt/mssql-tools/bin"
export PATH="$PATH:/home/sergey/.poetry/bin"

USE_DAAL4PY_SKLEARN=YES
alias tsm=transmission-remote
export PATH="$PATH:/home/sergey/Polyspace/R2020b/bin"


#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sergey/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sergey/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sergey/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sergey/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#conda activate py39
export TERM=screen-256color-bce
source ~/.bash_completion/alacritty
shopt -s globstar
shopt -s extglob
alias ls='lsd -hA --group-dirs first'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
export PATH="/home/sergey/.local/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source ~/.trueline/trueline.sh
#source /home/sergey/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
printf '\n%.0s' {1..100}
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export PATH=$PATH:/home/sergey/julia-1.6.1/
export PATH="$HOME/.rbenv/bin:$PATH"
export GEM_HOME="$HOME/gems"
export PATH="/home/sergey/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
alias v="vim"
alias sudo='sudo '
export PATH="/home/sergey/nvim-linux64/bin:$PATH"
alias v="nvim -u /home/sergey/scala.vimrc"
alias R='R --no-save'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sergey/google-cloud-sdk/path.bash.inc' ]; then . '/home/sergey/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sergey/google-cloud-sdk/completion.bash.inc' ]; then . '/home/sergey/google-cloud-sdk/completion.bash.inc'; fi

#yarn
export PATH="$(yarn global bin):$PATH"

#manage dot files
alias config='/usr/bin/git --git-dir=/home/sergey/.cfg/ --work-tree=/home/sergey'
