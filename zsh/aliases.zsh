if [ "$(uname)" = "Linux" ]; then
  # "-B" to hide backup files (ends with ~)
    alias ls='ls --color=auto -B'
fi

alias cdr='cd $(git rev-parse --show-toplevel)'
alias fn='find . -name'
(( $+commands[fdfind] )) ||(( $+commands[fd] )) || alias fd='find . -type d -name'
alias g='git'
alias gg='git grep'
alias ggi='git grep -i'
alias grep='pager_wrapper grep --color=auto'
alias h='hg'
alias home='cd $HOME'
alias kf='kill -9'
alias less='less -N'
alias ll='ls -lrtah'
alias lower="tr '[:upper:]' '[:lower:]'"
alias m='make -j'
alias mt='make -j test'
alias nv='nvim'
alias p='ps --sort=start_time aux | grep '
alias reboot='sudo reboot now'
alias t='tmux'
alias tl="tmux ls"
alias tn="tmux new-session"
alias tns="tmux new-session -s"
alias ta="tmux attach"
alias tat="tmux attach -t"
alias to_clipboard='xclip -selection c'
alias topcpu='/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias upper="tr '[:lower:]' '[:upper:]'"
alias v='vim'
alias wfc='curl "wttr.in/nyc?m"'
alias jdk11='PATH="/usr/local/buildtools/java/jdk11/bin:$PATH"'
[ -f ~/.zsh_local/zshrc_local_aliases.zsh ] && source ~/.zsh_local/zshrc_local_aliases.zsh

alias pip=pip3
