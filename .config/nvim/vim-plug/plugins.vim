" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/autoload/plugged')

    " UTILITIES
    Plug 'scrooloose/NERDTree'                              " file explorer
    Plug 'sheerun/vim-polyglot'                             " better syntax highlighting
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " intellisense
    Plug 'airblade/vim-gitgutter'                           " git info in side bar
    Plug 'lervag/vimtex'                                    " latex tools
    Plug 'jiangmiao/auto-pairs'                             " auto close pairs
    Plug 'luochen1990/rainbow'                              " colorize pairs
    Plug 'unblevable/quick-scope'                           " enhanced f, F, t, T
    Plug 'justinmk/vim-sneak'                               " two letter jump to
    Plug 'nvim-lua/plenary.nvim'                            " better fzf
    Plug 'nvim-telescope/telescope.nvim'                    " better fzf
    Plug 'ap/vim-css-color'                                 " highlight hex colors
    Plug 'junegunn/goyo.vim'                                " zen mode
    Plug 'junegunn/limelight.vim'                           " light up only focused text
    Plug 'tpope/vim-commentary'                             " better commenting
    Plug 'mhinz/vim-startify'                               " add start screen to vim
    
    " AESTHETIC
    " themes
    Plug 'morhetz/gruvbox'
    Plug 'joshdick/onedark.vim'
    Plug 'haishanh/night-owl.vim'
    Plug 'romainl/flattened'
    Plug 'whatyouhide/vim-gotham'
    Plug 'embark-theme/vim', { 'as': 'embark' }
    Plug 'sainnhe/everforest'
    Plug 'sainnhe/sonokai'
    " line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'

call plug#end()
