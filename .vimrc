"
"    ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄  
"   ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█  
"    ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄ 
"     ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"      ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"      ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"      ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒   
"        ░░   ▒ ░░      ░     ░░   ░ ░        
"         ░   ░         ░      ░     ░ ░      

" ----- BASIC OPTIONS ---
syntax on 
set nu
set ruler
set relativenumber
set wrap

set smartindent
set autoindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab
set backspace=indent,eol,start
" set cursorline
set showcmd
set lazyredraw
set showmatch
set incsearch
set hlsearch
set guifont=iosevka--12

" ----- KEYBINDINGS -----
map <SPACE> <leader>
map <SPACE><SPACE> <leader><leader>
nnoremap <leader>o o<ESC>
nnoremap <leader>ww <C-w><C-w>
nnoremap <leader>tr >>
nnoremap <leader>tl <<
vnoremap <leader>tr >gv
vnoremap <leader>tl <gv
nnoremap <leader>; $a;<ESC>
nnoremap <leader>bs <C-u>zz
nnoremap <leader>fs <C-d>zz

inoremap jk <ESC>
