" Remap leader
map <space> <leader>
map <space><space> <leader><leader>

" Easy escape
inoremap jk <Esc>

" Easy save
nnoremap <leader>s :w<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" TAB and SHIFT TAB to navigate buffers
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Copy paste (requires xsel)
vnoremap <C-c> "*Y :let @+=@*<CR>
map <C-p> "+P

" Editing
nnoremap <leader>; $a;<ESC>

" Packages
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
