" Remap leader
let g:mapleader = "\<Space>"
map <space> <leader>
map <space><space> <leader><leader>

map <leader><leader>sc :source $MYVIMRC<CR>
map <leader><leader>ec :e $MYVIMRC<CR>

" Easy escape
inoremap jk <Esc>

nnoremap <silent> j gj
nnoremap <silent> k gk

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
nnoremap <silent> <C-H> <C-w>H
nnoremap <silent> <C-J> <C-w>J
nnoremap <silent> <C-K> <C-w>K
nnoremap <silent> <C-L> <C-w>L

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" TAB and SHIFT TAB to navigate buffers
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Folding options
nnoremap <silent> <CR> @=(foldlevel('.')?'za':"j")<CR>
" vnoremap <CR> zf

" Copy paste using system clipboard (requires xsel)
vnoremap <C-c> "*Y :let @+=@*<CR>
map <C-p> "+P

" More convenient marks - easier to go to specific mark position instead of beg of line
nnoremap ' ` 
nnoremap ` '

" Editing
nnoremap <silent> <leader>; $a;<ESC>

" Clear search highlights
nnoremap <silent> <leader><Esc> <Esc>:nohlsearch<CR><Esc>

" Repeat last command with :
nnoremap !! @:

" Save and close buffer
:command Wd write|bdelete
" Switch to another open buffer on close (useful when NERDTree open)
:command Bd bp|bd\#<CR>


"----- PACKAGES -----
nnoremap <silent> <leader>g :Goyo<CR>
nnoremap <silent> <Leader>ll :Limelight!!<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
vnoremap ++ <plug>NERDCommenterToggle
nnoremap ++ <plug>NERDCommenterToggle

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
