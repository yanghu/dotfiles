# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
plugins=(adb alias-tips common-aliases extract fasd history git zsh-completions)
source $ZSH/oh-my-zsh.sh
source ~/.zsh/zsh-async/async.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
# Base16 Shell
source ~/.config/base16-shell/base16-shell.plugin.zsh
# To customize prompt, run `p11k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/p10k.zsh ]] || source ~/.zsh/p10k.zsh
