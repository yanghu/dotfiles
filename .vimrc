"let g:pathogen_disabled = ["nerdcommenter"]
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype on
filetype plugin indent on

set background=dark
colorscheme solarized
set number

set foldmethod=indent
set foldlevel=99

" Use actual tab chars in Makefiles.
autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab

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
map <F7> :PymodeLint<CR>

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

nnoremap <F5> :GundoToggle<CR>
nmap <F8> :TagbarToggle<CR>

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


let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:ctrlp_working_path_mode = 'ra'
"mac/ios
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,.DS_Store,*/.metadata/*
"windows:
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/]\.(git|hg|svn|metadata)$',
\ 'file': '\v\.(exe|so|dll|zip|pyc|DS_Store)$',
\ 'link': 'some_bad_symbolic_links',
\ }

" use git's index if possible.
let g:ctrlp_user_command = {
            \ 'types': {
  \ 1: ['.git', 'cd %s && git ls-files'],
  \ 2: ['.hg', 'hg --cwd %s locate -I .'],
  \ },
  \ 'fallback': 'find %s -type f' 
  \ }

"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

nnoremap <C-]> g<C-]>
"let g:easytags_on_cursorhold = 0
"let g:easytags_auto_highlight = 0

if &shell =~# 'bin/fish$'
    set shell=/bin/sh
endif

"nerdtree bookmark
autocmd Filetype nerdtree nnoremap <buffer> <leader>b :Bookmark<space>
let g:NERDTreeShowBookmarks=1
let NERDTreeIgnore = ['\.pyc$']

nnoremap <F2> :NERDTreeToggle<CR>

" ,cd to change cwd to current folder
nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>

cnoremap     <C-v> <C-\>esubstitute(getline('.'), '^\s*\(' . escape(substitute(&commentstring, '%s.*$', '', ''), '*') . '\)*\s*:*' , '', '')<CR>

"for golang
au FileType go nmap <leader>r <Plug>(go-run)


" close the buffer and keep window
nnoremap <C-c> :bp\|bd #<CR>
