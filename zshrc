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
source ~/.zsh/fzf.zsh

if [ -f ~/.zsh_local/zshrc_local_after.zsh ]; then
    source ~/.zsh_local/zshrc_local_after.zsh
fi

pathDeduplicate

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
