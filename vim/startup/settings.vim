set nocompatible
set backup                      " Be safe.
set formatoptions=crqn1j         " See :help fo-table.
set history=1000                " Remember a lot.
set shell=sh                    " I use fish-shell. Vim shouldn't.
set showcmd                     " Show the last command.
set viewoptions=cursor,folds    " Save cursor position and folds.

"" ============================================================================
""                                  Globals
"" ============================================================================
set noesckeys                   " Removes the annoying delay after ESC
"" encoding
scriptencoding utf-8
set encoding=utf-8

" Determine Environment
let g:platform=GetPlatform()

set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized8

"" ============================================================================
""                            Editing and Moving
"" ============================================================================
syntax on
filetype plugin indent on

set autoindent
" copy the previous indentation on autoindenting
set copyindent
set cindent

" make backspace traverse between lines
set backspace=indent,eol,start

" simulate indent level when wrapping lines
set breakindent
" shift over when wrapping lines
set breakindentopt+=shift:2

" Disable mouse for now
" " oh no, mouse
" set mouse=a

" if has("mouse_sgr")
"   set ttymouse=sgr
" else
"   set ttymouse=xterm2
" end

" Backup directory for swp files
set noswapfile
set directory=""

" runtime path search for Ex
set ru

" Fixing tabs
set tabstop=2
set expandtab
set shiftwidth=2
" makes indenting a multiple of shiftwidth
set shiftround
" make backspace eat a tab worth of spaces
set smarttab

" Allow switching off modified buffers without warning
set hidden

" automatically reload file on change
set autoread

" make diff windows match by adding filler
set diffopt+=filler

" diff in vertical split
set diffopt+=vertical

" Smart case sensitivity
set ignorecase
set smartcase

" Fix background color
set t_ut=

" When multiple completions are possible, show all
set wildmenu

" Complete only up to point of ambiguity, like the shell does; allow to tab
" through
set wildmode=longest,list,full

" Ignoring files (see :help wildignore)
set wildignore+=*.o,*.d,00*,nohup.out,tags,.hs-tags,*.hi,*.gcno,*.gcda,*.fasl,*.pyc
"mac/ios
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,.DS_Store,*/.metadata/*

" Ignore case sensitivity in filenames
set wildignorecase

" stores undo state even when files are closed (in undodir)
if !isdirectory($HOME . '/.vim/backups')
  call mkdir($HOME . '/.vim/backups', 'p')
endif
set undodir=~/.vim/backups
set undofile

" allow for scrolling to next/prev line with left/right
set whichwrap+=<,>,h,l,[,]

" This shortens about every message to a minimum and thus avoids scrolling within
" the output of messages and the 'press a key' prompt that goes with these
set shm=at

" use system clipboard by default
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  else
    set clipboard=unnamed
  endif
endif

" Instead of failing a command because of unsaved changes, raise a dialogue
" asking if you wish to save changed files.
set confirm

" Enables regex in search patterns.
set magic

"" ============================================================================
""                                Appearance
"" ============================================================================
" Show line numbers
set number
set relativenumber

" show the cursor position
set ruler
set cc=80
set cursorline                  " Highlight the current line.


" no linewrap
set nowrap

" whitespace characters
set listchars=tab:»-,trail:-

" enable display of whitespace
set list

" Make splitting more natural
set splitright splitbelow

" Splits (don't) resize on open/close
set noequalalways

" Incremental search and sighlighting sesults
set incsearch
set hlsearch

" enable search to to wrap around the buffer
set wrapscan

" Always show status bar
set laststatus=2

" Set the folding method
set foldmethod=manual
set foldnestmax=3
set foldminlines=10
" but don't use folds because they're annoying
set nofoldenable

" double click to highlight all occurrences
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" Don't make noise.
set visualbell

" Number of lines to scroll past when the cursor scrolls off the screen
set scrolloff=3

" increase preview window height from default
set previewheight=15

" don't redraw when executing macros
set lazyredraw

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Smoother redraws
set ttyfast

" Change cursor style for insert mode.
let &t_SI = "\e[6 q"
let &t_EI = "\e[0 q"

" Don't print mode on last status line
set noshowmode

"" ============================================================================
""                               Auto Commands
"" ============================================================================
" Quickfix
autocmd FileType qf setlocal colorcolumn=

" XML
autocmd FileType xml setlocal equalprg=xmllint\ --format\ -

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" set appropriate commentstrings
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType textpb setlocal commentstring=#\ %s

" formatting for netrw
autocmd FileType netrw setlocal nolist colorcolumn=

" equalize splits when window resized
autocmd VimResized * exe "normal! \<c-w>="

" Auto switch relative number on entering normal mode.
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
