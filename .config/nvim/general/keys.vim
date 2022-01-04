" Remap leader
let g:mapleader = "\<Space>"
map <space> <leader>
map <space><space> <leader><leader>

" " Remap leader
" let g:mapleader = ","
" map , <leader>
" map ,, <leader><leader>

" nnoremap : ,
" vnoremap : ,
" nnoremap <space> :
" vnoremap <space> :

map <leader><leader>sc :source $MYVIMRC<CR>
map <leader><leader>ec :e $MYVIMRC<CR>

" Easy escape
inoremap jk <Esc>

" Always traverse lines visually
nnoremap j gj
nnoremap k gk

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Yank to end of line
nnoremap Y y$

" Replace highlighted text with last yanked
vnoremap <leader>p "_dP

" Easy save
nnoremap <silent> <leader>w :w<CR>

" Better window navigation
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows
nnoremap <silent> <M-j> :resize -2<CR>
nnoremap <silent> <M-k> :resize +2<CR>
nnoremap <silent> <M-h> :vertical resize -2<CR>
nnoremap <silent> <M-l> :vertical resize +2<CR>

" Move windows
" nnoremap <silent> <C-H> <C-w>H
" nnoremap <silent> <C-J> <C-w>J
" nnoremap <silent> <C-K> <C-w>K
" nnoremap <silent> <C-L> <C-w>L

" Set undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap ( (<C-g>u

" Move selected text
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Better nav for omnicomplete
inoremap <expr> <C-j> ("\<C-n>")
inoremap <expr> <C-k> ("\<C-p>")

" TAB and SHIFT TAB to navigate buffers
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>
nnoremap <silent> <BACKSPACE> <C-^>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Renaming
 nmap <leader>rn <Plug>(coc-rename)
 nmap <F2> <Plug>(coc-rename)

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Folding options
" nnoremap <silent> <CR> @=(foldlevel('.')?'za':"j")<CR>
" vnoremap <CR> zf

" Copy paste using system clipboard (requires xsel)
vnoremap <C-c> "*Y :let @+=@*<CR>
map <C-p> "+P

" More convenient marks - easier to go to specific mark position instead of beg of line
nnoremap ' ` 
nnoremap ` '

" Editing
nnoremap <silent> <leader>; $a;<ESC>
inoremap <C-BS> <C-w>
inoremap  <C-w>
inoremap <C-q> <C-\><C-o>dB


" Clear search highlights
nnoremap <silent> <leader><Esc> <Esc>:nohlsearch<CR><Esc>

" Repeat last command with :
nnoremap !! @:

" Close buffer
nnoremap <silent> <leader>x :bd<CR>
nnoremap <silent> <C-w> :bd<CR>

" Save and close buffer
:command Wd write|bdelete
" Switch to another open buffer on close (useful when NERDTree open)
:command Bd bp|bd\#<CR>

" Get highlight group for object under cursor
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <C-p> :call <SID>SynStack()<CR>

" LaTeX
nnoremap <leader>$ ciW$$<ESC>P
nnoremap <leader>fm ciW$$<ESC>P
" inoremap begenum \begin{enumerate}<ESC>yypjlciwend

" Editing text files
nnoremap <leader>et :set wrap linebreak spell nocursorline<CR>
nnoremap <leader>sp z=

"----- PACKAGES -----

" invert two consecutive blocks of code
nmap gcik gcckgcc
nmap gcij gccjgcc
nmap gC gcc

nnoremap <silent> <leader>g :Goyo<CR>
nnoremap <silent> <Leader>ll :Limelight!!<CR>
" NvimTreeOpen, NvimTreeClose and NvimTreeFocus are also available if you need them
nnoremap <C-n> :NvimTreeToggle<CR>


" Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').colorscheme()<cr>
