"VIMRC file for PC

let g:pathogen_disabled = ["vim-easytags","YouCompleteMe"]
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype on
filetype plugin indent on

if has('gui_running')
  set guifont=DejaVu_Sans_Mono_for_Powerline:h12:cANSI
endif

if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
endif

set background=dark
colorscheme solarized
set number

set foldmethod=indent
set foldlevel=99

let g:tagbar_ctags_bin='C:\bin\ctags58\ctags.exe'

autocmd Filetype nerdtree nnoremap <buffer> <leader>b :Bookmark<space>
let g:NERDTreeShowBookmarks=1

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on
    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.


au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = \"context\"
"set completeopt=menuone,longest,preview


let g:pymode_lint_sort = ['E', 'C', 'I']

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h



" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

let g:ycm_filetype_specific_completion_to_disable = {
      \ 'gitcommit': 1,
      \ 'php': 1
      \}

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

let g:UltiSnipsEditSplit="vertical"

set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 0
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }

" Multiple VCS's. USE VCS's index for faster file indexing
let g:ctrlp_user_command = {
\ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files'],
  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
\ 'fallback': 'dir %s /-n /b /s /a-d' 
\ }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

nnoremap <C-]> g<C-]>
let g:easytags_on_cursorhold = 0
let g:easytags_auto_highlight = 0

if &shell =~# 'bin/fish$'
    set shell=/bin/sh
endif

"set shell=powershell
"set shellcmdflag=-command

"cd D:\AnsysDev\nextgen

" ,cd to change directory to current file directory(for this buffer)
nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>

map <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>
nnoremap <F5> :!ctags -R
nnoremap <F6> :GundoToggle<CR>
map <F7> :PymodeLint<CR>
nmap <F8> :TagbarToggle<CR>
