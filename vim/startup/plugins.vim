call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'     " Syntax cheching.
Plug 'neoclide/coc.nvim', { 'branch': 'release' }      " Auto complete
Plug 'easymotion/vim-easymotion'                          " I get around round round round
Plug 'haya14busa/vim-poweryank'                           " yank over SSH
Plug 'michaeljsmith/vim-indent-object'                    " indentation-level text objects (ai/I, ii/I)
" Plug 'benmills/vimux'                                     " Vim and Tmux Integration
Plug 'tpope/vim-commentary'                               " Comment/uncomment operator
Plug 'tpope/vim-fugitive'                                 " Git Wrapper
Plug 'tpope/vim-surround'                                 " Surrounding text
Plug 'tpope/vim-obsession'                                 " Surrounding text
Plug 'tpope/vim-unimpaired'                                 " Surrounding text
Plug 'chriskempson/base16-vim'     "colortheme
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-repeat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'
Plug 'nathangrigg/vim-beancount'
Plug 'jmcantrell/vim-virtualenv'
" Plug 'tmhedberg/SimpylFold'
" The plugin is compatible with fzf up to this version (b/190191359).
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
" Plug 'sirver/ultisnips'                                   " snippet engine with integration into ycm; needs vim compiled with python
"Plug 'scrooloose/syntastic'
call plug#end()

"" ============================================================================
""                              Plugin Settings
"" ============================================================================

" indentLine set conceal level to 2, which breaks markdown.
" let g:indentLine_fileTypeExclude = ['json', 'markdown']
let g:vim_markdown_syntax_conceal = 0
let g:vim_json_syntax_conceal = 0

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
" set colors
hi link EasyMotionTarget WarningMsg
hi link EasyMotionShade  Comment

" vim-table-mode
let g:table_mode_corner='|'

" Ale
" turn off convention pylint messages and misc
let g:ale_disable_lsp = 1
let g:ale_python_pylint_options='--disable=C --disable=W0311'
let g:ale_java_checkstyle_options='-c ~/.vim/config/checkstyle_custom_checks.xml'
let g:ale_linters={
      \  'cpp': ['cppcheck'],
      \  'java': ['checkstyle'],
      \  'zsh': ['shellcheck'],
      \  'markdown': [],
      \}

" Fugitive
" automatically delete fugitive buffers when leaving them
autocmd BufReadPost fugitive://* set bufhidden=delete

" coc extensions
if g:platform == "Linux" && !AtWork()
  let g:coc_global_extensions = ['coc-lists', 'coc-clangd']
elseif AtWork()
  let g:coc_global_extensions = ['coc-lists']
endif
" Common coc user config for personal and work profiles.
" Additional ones can be added by calling 
" let g:coc_user_config = extend(g:coc_user_config, another_dict)
let g:coc_user_config = {
  \  "suggest": {
  \    "maxCompleteItemCount": 15,
  \    "minTriggerInputLength": 1,
  \    "lowPrioritySourceLimit": 5,
  \    "removeDuplicateItems": v:true
  \  },
  \  "list":{
  \    "previewSplitRight": v:true,
  \    "insertMappings": {
  \      "<C-p>": "do:previewtoggle",
  \      "<C-v>": "action:vsplit",
  \      "<C-x>": "action:delete",
  \      "<C-q>": "action:quickfix"
  \    },
  \    "normalMappings": {
  \      "v": "action:vsplit",
  \      "q": "action:quickfix",
  \      "x": "action:delete"
  \    },
  \    "source": {
  \      "files.excludePatterns": ["**/.git/**"]
  \    }
  \  }
  \}

au FileType beancount let b:coc_suggest_disable = 1
au FileType markdown let b:coc_suggest_disable = 1

" FZF
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_OPTS .= '--bind ctrl-a:select-all'

" Snippet from
" https://github.com/junegunn/fzf.vim/issues/837#issuecomment-1179386300
" Search with ripgrep and fzf with folder specs
" Defult starts in git root folder
" Examples:
"   :Rg2 "apple teste" ./folder_test
"   :Rg2 --type=js "apple"
"   :Rg2 --fixed-strings "apple"
"   :Rg2 -e -foo
"   :Rg2 vim ~/repo/hugo --glob "*.md" 
command! -bang -nargs=* Rg2
  \ call fzf#vim#grep(
  \ "rg --column --line-number --no-heading --color=always --smart-case ".<q-args>,
  \ 1, {'dir': system('git -C '.expand('%:p:h').' rev-parse --show-toplevel 2> /dev/null')[:-2]},
  \ <bang>0)
" Git grep wrapper using fzf. Example usage
" Examples:
"   :GGrep "app teste"
"   :GGrep "app teste" HEAD~
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.<q-args>,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
" command! -bang -nargs=* GGrep
"   \ call fzf#vim#grep(
"   \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
"   \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
set statusline^=%{coc#status()}

let g:ale_lint_on_insert_leave = 0

if g:platform == "Linux" && !AtWork()
" Code formatter
  augroup autoformat_settings
    autocmd FileType bzl AutoFormatBuffer buildifier
    " autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    autocmd FileType c,cpp,proto,javascript,arduino clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    " autocmd FileType python AutoFormatBuffer yapf
    " autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType rust AutoFormatBuffer rustfmt
    autocmd FileType vue AutoFormatBuffer prettier
  augroup end
endif


augroup fugitive
  " Fugitive automatically delete fugitive buffers when leaving them
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup end
