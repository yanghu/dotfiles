"" ============================================================================
""                             All Mode Mappings
"" ============================================================================
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Default is \, I prefer ,.
" let mapleader=","
let mapleader="<space>"
imap jk <Esc>

" Avoid going to ex mode
nmap Q <Nop>

" quickly edit vimrc
nnoremap ,rc :e ~/.vimrc<CR>
" Re-enter pwd.
nnoremap ,rr :cd $PWD<CR>
"" ============================================================================
""                          Motion and Editing
"" ============================================================================
" Scroll a little bit faster.
nnoremap <C-y> 3<C-y>
nnoremap <C-e> 3<C-e>

" Surrounding: ,{ to insert {} in a new line
imap <Leader>{ <c-g>S{
imap <Leader>( <c-g>S(

nnoremap <c-n> :bnext<cr>
nnoremap <c-p> :bprev<cr>
" close the buffer and keep window
nnoremap <C-c> :bp\|bd #<CR>
" Space to clear search highlightin
nmap <space> :<c-u>noh<cr>:<backspace>
" Quickly save file
nnoremap XX :<c-u>update<CR>
" Toggle paste mode
nnoremap <Leader>p :se invpaste paste?<return>
" %% in command line auto expand to folder of current buffer.(%:h)
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" ========== easymotion
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>w <Plug>(easymotion-w)
map <Leader>f <Plug>(easymotion-f)
" Move at current line.(word start/end, camel and brackets.
map <Leader>ee <Plug>(easymotion-lineanywhere)
" Enter n characters and use easy motion to move.
nmap <Leader>es <Plug>(easymotion-sn)
" nmap <Leader>/ <Plug>(easymotion-sn)

" upper case markers improves readability. You can still navigate using lower
" letters.
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'

" ==== Golang specific
"use [[ and ]] to jump between methods
au FileType go nmap [[ ?^func <CR>
au FileType go nmap ]] /^func <CR>

"" ============================================================================
""                          Completion and List(coc) 
"" ============================================================================

" First unmap ultisnips mappings otherwise it conflicts with coc
let g:UltiSnipsExpandTrigger = "<NUL>"
let g:UltiSnipsListSnippets = "<NUL>"
let g:UltiSnipsJumpForwardTrigger = "<NUL>"
let g:UltiSnipsJumpBackwardTrigger = "<NUL>"
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
inoremap <silent><expr> <Leader>a coc#refresh()
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<tab>"
inoremap <expr> <c-j>   pumvisible() ? "\<C-n>" : "\<c-k>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<c-j>"
inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrClosePumOrReturnNewline()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" Coc search mappings
" Search the word under cursor
nnoremap <Leader>gw :Rg2 <c-r><c-w>
nnoremap <Leader>gW "gyiW :Rg2 <c-r>g
vnoremap <Leader>gg "gy :Rg2 <c-r>=@g<CR>
" Search current folder using fzf+ripgrep.
nnoremap <Leader>gg :Rg2<Space>
" Resume coclist results
" nnoremap <Leader>cc :CocListResume<CR>

nnoremap <Leader>gl :silent lgrep<Space>

" CocList mappings, prefixed with ,l
" nnoremap <Leader>b :CocList buffers<CR>
" nnoremap <Leader>lc :CocList files<CR>
" Use fzf to view buffers and files, which is faster and better-looking
",b to open buffers
nnoremap <Leader>b :Buffers<CR>
" open file in PWD
nnoremap <Leader>lc :Files<CR>
" open current git repo of current file
nnoremap <Leader>gc :GFiles<CR>
" open git status files list
nnoremap <Leader>gs :GFiles?<CR>
" ,lc to open files from the current buffer's folder.
nnoremap <expr> <Leader>lf ":Files " . expand('%:p:h')
nnoremap <expr> <Leader>lv ":Files " . "$HOME/tmp/executions"
" nnoremap <expr> <Leader>lf ":CocList files " . expand('%:p:h')
" nnoremap <expr> <Leader>lv ":CocList files " . "$HOME/tmp/executions"

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
nnoremap <Leader>lO :CocList --no-quit outline<CR>

" Buffer history. Use coclist which has better sorting for MRU
nnoremap <Leader>lm :CocList mru -A<CR>
" nnoremap <Leader>lm :History<CR>
" quickfix
nnoremap <Leader>lq :CocList quickfix<CR>

" nnoremap <Leader>l* :CocList -I words<CR>
" Serach in all open buffers
nnoremap <Leader>l* :Lines<space>
" Search in current buffer
nnoremap <Leader>lb :BLines<CR>
nnoremap <Leader>/ :BLines<space>
" Search word under cursor in all opened buffers. Search with rg see ,gw
nnoremap <Leader>lw :exe 'Lines ' . expand('<cword>')<CR>
nnoremap <Leader>ll :CocList 

" Quickly moving btween ale linter errors
nmap <silent> ,ak <Plug>(ale_previous_wrap)
nmap <silent> ,aj <Plug>(ale_next_wrap)

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

" Vimux
" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <Leader>vs "vy :call VimuxRunCommand(@v)<CR>
" Select current paragraph and send it to tmux
nmap <Leader>vs vip<Leader>vs<CR>

" If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <Leader>vl "vy :call VimuxPromptCommand(@v . " > ~/tmp/executions/tmp")<CR>
" Select current paragraph and send it to tmux
nmap <Leader>vl vip<Leader>vl

" Easy align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"" ============================================================================
""                          Digraph
"" ============================================================================
" C-k is already mapped to auto complete selection movement.
inoremap <c-g> <c-k>

" Beancount
augroup beancount_settings
  autocmd FileType beancount nnoremap <buffer> <Leader>= :AlignCommodity<CR>
  autocmd FileType beancount vnoremap <buffer> <Leader>= :AlignCommodity<CR>
  autocmd FileType beancount inoremap <buffer> . .<C-\><C-O>:AlignCommodity<CR>
  autocmd FileType beancount inoremap <buffer> <Nul> <C-x><C-o>
augroup end

" Use ripgrep for external vimgrep
if executable('rg')
  set grepformat+=%f:%l:%c:%m
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif
