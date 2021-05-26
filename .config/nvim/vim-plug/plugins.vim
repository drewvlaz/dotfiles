" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Intellisense
    "Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Rainbow pairs
    Plug 'luochen1990/rainbow'
    " CSS Colors
    Plug 'ap/vim-css-color'
    " Read mode
    Plug 'junegunn/goyo.vim'
    " Block commenting
    Plug 'preservim/nerdcommenter'
    " Themes
    Plug 'morhetz/gruvbox'
    Plug 'christianchiarulli/onedark.vim'
    " Status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

call plug#end()
