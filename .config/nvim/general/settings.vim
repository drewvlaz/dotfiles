" FUNCTIONALITY
set encoding=utf-8                      " The encoding displayed
set fileencoding=utf-8                  " The encoding written to file
set hidden                              " Required to keep multiple buffers open
set mouse=a                             " Enable your mouse
set iskeyword+=-                      	" Treat dash separated words as a word text object"
set iskeyword+=_                      	" Treat underscore separated words as a word text object"
set splitbelow splitright		        " Splits in appropriate direction
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
" set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set smartindent
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set clipboard=unnamedplus               " Copy paste between vim and everything else
set backspace=indent,eol,start		    " Proper backspace functionality
set updatetime=300                      " Faster completion
set timeoutlen=400                      " By default timeoutlen is 1000 ms
set smartcase
" set foldmethod=indent                   " fold using indentation

" AESTHETIC
syntax on                               " Enable syntax highlighting
set number                              " Line numbers
" set relativenumber		                " Relative line numbers
set nowrap                              " Display long lines as just one line
set ruler				                " Show the cursor position all the time
set cursorline                          " Enable highlighting of the current line
set pumheight=10                        " Makes popup menu smaller
set cmdheight=2                         " More space for displaying messages
set conceallevel=2                      " So that I can see `` in markdown files
set laststatus=2                        " Always display the status line
set scrolloff=5                         " Keep cursor X lines away from edge when scrolling
set noshowmode                          " Disable showing mode at bottom
set t_Co=256                            " Support 256 colors
" set signcolumn=no                       " Remove bar on left side, has git info
" set guifont=Fira\ Code\ Nerd\ Font:h13
set guifont=OperatorMono\ Nerd\ Font\ Mono:h13
if (has("termguicolors"))
    set termguicolors
endif

" AUTOCMDS
autocmd InsertEnter * norm zz                                                       " center screen when entering insert mode
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o      " Disable automatic commenting on new line
" autocmd BufWritePre * %s/\s\+$//e	                                                  " Delete trailing whitespace on save
" Save folds between sessions
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview
