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
if !has('nvim')
set noesckeys                   " Removes the annoying delay after ESC
endif
"" encoding
scriptencoding utf-8
set encoding=utf-8

" Determine Environment
let g:platform=GetPlatform()

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark

autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
let g:airline_theme='base16_gruvbox_dark_hard'
" if filereadable(expand("~/.vimrc_background"))
"   source ~/.vimrc_background
" else
"   set t_Co=256
"   let g:solarized_termcolors=256
"   colorscheme solarized8
" endif

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
if !has("nvim")
set undodir=~/.vim/backups
endif
set undofile
set backupdir=~/.vim/backups

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
set foldnestmax=2
set foldminlines=5
set foldlevelstart=2
" set nofoldenable
let g:markdown_folding=1

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
"set nostartofline

" Smoother redraws
set ttyfast

" Change cursor style for insert mode.
let &t_SI = "\e[6 q"
let &t_EI = "\e[0 q"

" Don't print mode on last status line
set noshowmode

" netrw

" Tree style
let g:netrw_liststyle = 3
" Vertical preview splitting
let g:netrw_preview = 1
" Use 30% screen width
let g:netrw_winsize = 30
"" ============================================================================
""                               Auto Commands
"" ============================================================================
" Quickfix
autocmd FileType qf setlocal colorcolumn=

" XML
autocmd FileType xml setlocal equalprg=xmllint\ --format\ -

" Markdown
augroup markdown_setings
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  au FileType markdown let g:indentLine_setConceal= 0
  let g:vim_markdown_conceal = 0
  let g:vim_markdown_conceal_code_blocks = 0
augroup end

" set appropriate commentstrings
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType textpb setlocal commentstring=#\ %s

" formatting for netrw
autocmd FileType netrw setlocal nolist colorcolumn=

" equalize splits when window resized
autocmd VimResized * exe "normal! \<c-w>="

" " From https://vi.stackexchange.com/questions/13864/bufwinleave-mkview-with-unnamed-file-error-32
" augroup AutoSaveGroup
"   autocmd!
"   " view files are about 500 bytes
"   " bufleave but not bufwinleave captures closing 2nd tab
"   " nested is needed by bufwrite* (if triggered via other autocmd)
"   " BufHidden for for compatibility with `set hidden`
"   autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
"   autocmd BufWinEnter ?* silent! loadview
" augroup end
" augroup! AutoSaveGroup

" Auto switch relative number on entering normal mode.
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup end


au BufRead,BufNewFile *.keymap setfiletype cpp

" for folding beancount files with org markers ***
function! MarkdownLevel()
    if getline(v:lnum) =~ '^\* .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^\*\* .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^\*\*\* .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^\*\*\*\* .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^\*\*\*\*\* .*$'
        return ">5"
    endif
    if getline(v:lnum) =~ '^\*\*\*\*\*\* .*$'
        return ">6"
    endif
    return "=" 
endfunction
au BufEnter *.bean setlocal foldexpr=MarkdownLevel()  
au BufEnter *.bean setlocal foldmethod=expr     
au BufEnter *.bean setlocal fml=1
au BufEnter *.bean setlocal foldopen-=block

au FileType beancount setlocal foldlevel=3
au FileType beancount,markdown nnoremap <space> za
