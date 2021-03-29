"" ============================================================================
""                             All Mode Mappings
"" ============================================================================
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Default is \, I prefer ,.
let mapleader=","
imap jk <Esc>

"" ============================================================================
""                          Motion and Editing
"" ============================================================================

" close the buffer and keep window
nnoremap <C-c> :bp\|bd #<CR>
" Space to clear search highlightin
nmap <space> :<c-u>noh<cr>:<backspace>
" ,e to return to netrw window
nnoremap <Leader>e :Rex<CR>
" Quickly save file
nnoremap XX :<c-u>update<CR>
" Toggle paste mode
nnoremap <leader>p :se invpaste paste?<return>
" %% in command line auto expand to folder of current buffer.(%:h)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
" ========== easymotion
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" ==== Golang specific
"use [[ and ]] to jump between methods
au FileType go nmap [[ ?^func <CR>
au FileType go nmap ]] /^func <CR>

"" ============================================================================
""                          Completion and List(coc) 
"" ============================================================================

" 1. when pumvisible & entry selected, which is a snippet, <CR> triggers snippet expansion,
" 2. when pumvisible & entry selected, which is not a snippet, <CR> only closes pum
" 3. when pumvisible & no entry selected, <CR> closes pum and inserts newline
" 4. when pum not visible, <CR> inserts only a newline
function! s:ExpandSnippetOrClosePumOrReturnNewline()
    if pumvisible()
        if !empty(v:completed_item)
            return "\<C-y>"
        else
            return "\<C-y>\<CR>"
        endif
    else
        return "\<CR>"
    endif
endfunction
" Enter starts a new line even when popup is open, then continue with
" completion prompt. 

" Coc completion mappings
inoremap <silent><expr> <leader>a coc#refresh()
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<tab>"
inoremap <expr> <c-j>   pumvisible() ? "\<C-n>" : "\<c-k>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-j>"
inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrClosePumOrReturnNewline()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" CocList mappings, prefixed with ,l
nnoremap <Leader>f :CocList buffers<CR>     " ,f to open buffers
nnoremap <Leader>lf :CocList files<CR>     " ,lf to open files in cwd
" ,lc to open files from the current buffer's folder.
nnoremap <expr> <Leader>lc ":CocList files " . expand('%:p:h')
" outline with fuzzy search, preview. Insert mode mappings: 
" c-s: switch matcher mode(strict/fuzzy/regex)
" c-q: add to quickfix list
" c-p: preview window
" c-v: vertical split
" c-o: to normal mode.
" c-f/c-b: scroll window
" In Normal mode:
" p: preview,  t/d/s/v: tabe/drop/split/vsplit
" q: Add to quickfix
" ?: show help
" c-e/c-y: scroll preview window.
" c-o: jump to original window
nnoremap <Leader>lo :CocList --auto-preview outline<CR>
" Persistent outline window. May need manual refresh with c-l in normal mode.
" Use c-w H/L to move outline window to the side and resize.
nnoremap <Leader>lO :CocList --auto-preview --no-quit outline<CR>
nnoremap <Leader>lm :CocList mru<CR>         " mru
nnoremap <Leader>lq :CocList quickfix<CR>         " quickfix
nnoremap <Leader>ll :CocList 

"" ============================================================================
""                          Change of default behaviors 
"" ============================================================================
" Press * or # to search for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>:set hlsearch<CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>:set hlsearch<CR>


"" ============================================================================
""                          Plugins
"" ============================================================================
map <Leader>y <Plug>(operator-poweryank-osc52)
