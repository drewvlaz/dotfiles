let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256
let g:embark_terminal_italics = 1
let g:flattened_dark_terminal_italics = 1

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
endif

" colorscheme onedark
" colorscheme OceanicNext
" colorscheme night-owl
" colorscheme flattened_dark
" colorscheme gotham
" colorscheme gruvbox
" colorscheme embark
colorscheme everforest
" colorscheme sonokai

augroup special_formatting
    autocmd!
    autocmd Colorscheme * hi Comment gui=italic cterm=italic
    autocmd Colorscheme * hi String gui=italic cterm=italic
augroup END
" just use the terminal's background color
" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE

let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['cyan', 'lightmagenta', 'lightred', 'orange']}
