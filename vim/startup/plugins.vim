call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'     " Syntax cheching.
Plug 'neoclide/coc.nvim'      " Auto complete
Plug 'easymotion/vim-easymotion'                          " I get around round round round
Plug 'haya14busa/vim-poweryank'                           " yank over SSH
Plug 'michaeljsmith/vim-indent-object'                    " indentation-level text objects (ai/I, ii/I)
Plug 'benmills/vimux'                                     " Vim and Tmux Integration
Plug 'tpope/vim-commentary'                               " Comment/uncomment operator
Plug 'tpope/vim-fugitive'                                 " Git Wrapper
Plug 'tpope/vim-surround'                                 " Surrounding text
Plug 'chriskempson/base16-vim'     "colortheme
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-repeat'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
" Plug 'sirver/ultisnips'                                   " snippet engine with integration into ycm; needs vim compiled with python
"Plug 'scrooloose/syntastic'
call plug#end()

"" ============================================================================
""                              Plugin Settings
"" ============================================================================

let g:airline_theme='base16'
" indentLine set conceal level to 2, which breaks markdown.
let g:indentLine_fileTypeExclude = ['json', 'markdown']

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
" set colors
hi link EasyMotionTarget WarningMsg
hi link EasyMotionShade  Comment

" Ale
" turn off convention pylint messages and misc
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
  \      "<C-q>": "action:quickfix"
  \    },
  \    "normalMappings": {
  \      "v": "action:vsplit",
  \      "q": "action:quickfix"
  \    },
  \    "source": {
  \      "files.excludePatterns": ["**/.git/**"]
  \    }
  \  }
  \}


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
    autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    " autocmd FileType python AutoFormatBuffer yapf
    " autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType rust AutoFormatBuffer rustfmt
    autocmd FileType vue AutoFormatBuffer prettier
  augroup END
endif
