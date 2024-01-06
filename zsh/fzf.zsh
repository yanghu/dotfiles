# use tree to preview folders
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    vim)          fzf "$@" --preview 'bat --style=numbers --color=always --line-range :500 {}' ;;
    *)            fzf "$@" ;;
  esac
}

source ~/.zsh/fzf/completion.zsh
source ~/.zsh/fzf/key-bindings.zsh
