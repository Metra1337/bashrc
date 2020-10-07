# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If we have an existing TMUX Session, Connect to it. Else create one
if ! ps aux | grep -v grep | grep tmux &>/dev/null ; then
  pkill "ssh-agent"
  rm -f ~/.ssh-agent
  eval $(ssh-agent | grep -v echo | tee ~/.ssh-agent)
  chmod 600 ~/.ssh-agent
  tmux
else
  if [ -f ~/.ssh-agent ]; then
    source ~/.ssh-agent
    tmux attach 2>/dev/null
  else
    printf "problem\nproblem\nproblem\n"
  fi
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

NONE='\[\033[00;37m\]'
CYAN='\[\033[01;36m\]'
BLUE='\[\033[00;32m\]'
PINK='\[\033[01;35m\]'
GREEN='\[\033[00;36m\]'
RED='\[\033[01;31m\]'
PROMPT='[['$PINK'\D{%T}'$NONE'][`if [ $? = 0 ]; then echo "'$GREEN'●'$NONE'"; else echo "'$RED'●'$NONE'"; fi`]'$CYAN'\u'$NONE'@'$BLUE'\h'$NONE':'$GREEN'\w'$NONE']'$CYAN'$(parse_git_branch)'$NONE'\n\$>'
PS1=$PROMPT

#User specific aliases and functions
alias hosts="sudo /usr/bin/vim -Z /etc/hosts"
alias crontab="sudo /usr/bin/vim -Z /etc/crontab"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
