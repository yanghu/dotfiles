" Load functions
source ~/.vim/startup/functions/vimscript-helpers.vim
source ~/.vim/startup/functions/environment.vim
source ~/.vim/startup/functions/directories.vim
source ~/.vim/startup/functions/formatting.vim

" Load each specialized settings file
source ~/.vim/startup/settings.vim
source ~/.vim/startup/plugins.vim
source ~/.vim/startup/mappings.vim
source ~/.vim/startup/restore_view.vim

filetype plugin on
" Work-only config
call SourceIfExists('~/.vim_local/vimrc_after.vim')

