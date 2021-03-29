## ============================================================================
##                                 Settings
## ============================================================================
# Vim mode
#bindkey -v

bindkey '^r' history-incremental-search-backward
bindkey -M "vicmd" 'k' history-substring-search-up
bindkey -M "vicmd" 'j' history-substring-search-down

# Run `bindkey -l` to see a list of modes, and `bindkey -M foo` to see a list of commands active in mode foo
# Move to vim escape mode
bindkey -M "viins" kj vi-cmd-mode
bindkey -M "viins" kk vi-cmd-mode

# Unmap ctrl-s as "stop flow"
stty stop undef

# Shift-tab to cycle backwards in autocompletions
bindkey '^[[Z' reverse-menu-complete

# don't autocorrect
unsetopt correctall

# Don't save duplicated entries into history
setopt hist_ignore_all_dups

#  ============================================================================
#                            Configure Plugins
#  ============================================================================
# zsh-autosuggestions
# Bind <CTRL><SPC> to accept
bindkey '^ ' autosuggest-accept

#  ============================================================================
#                                   SSH
#  ============================================================================
# start agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

#  ============================================================================
#                                   FZF
#  ============================================================================
#[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
#[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
