echo "Loading zshrc"
if [ -f ~/.zsh_local/zshrc_local_before.zsh ]; then
    source ~/.zsh_local/zshrc_local_before.zsh
fi

source ~/.zsh/plugins.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/settings.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/fzf/completion.zsh
source ~/.zsh/fzf/key-bindings.zsh

if [ -f ~/.zsh_local/zshrc_local_after.zsh ]; then
    source ~/.zsh_local/zshrc_local_after.zsh
fi

pathDeduplicate

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# disable this line as "fzf --zsh" doesn't work: /usr/bin/fzf is used instead of the nvim version.
# [ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
