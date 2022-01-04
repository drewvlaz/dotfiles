" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
endif

let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256
let g:embark_terminal_italics = 1
let g:flattened_dark_terminal_italics = 1
let g:tokyonight_style = 'storm'
let g:tokyonight_enable_italic = 1

" colorscheme onedark
" colorscheme night-owl
" colorscheme flattened_dark
" colorscheme gotham256
" colorscheme gruvbox
" colorscheme embark
colorscheme everforest
" colorscheme sonokai
" colorscheme tokyonight

" syn match pythonFunctionKeyword "\v\s{-}\zs\w+\ze\=(\=)@!(\_s)@!" display
" syn cluster pythonExpression add=pythonFunctionKeyword
" syn region pythonFunctionKwargs start=+(+ end=+)+ contains=@pythonExpression

" apply on colorscheme changes
" augroup special_formatting
    autocmd!

    " italics for operator mono font
    autocmd Colorscheme * hi Comment gui=italic cterm=italic
    " autocmd Colorscheme * hi Comment gui=italic cterm=italic guifg=#757590  " better comments for tokyonight
    autocmd Colorscheme * hi String gui=italic cterm=italic
    " autocmd Colorscheme * hi pythonFunctionKeyword gui=italic cterm=italic

    " transparent window
    autocmd ColorScheme * hi Normal ctermbg=none guibg=none
    autocmd ColorScheme * hi NonText ctermbg=none guibg=none
    autocmd ColorScheme * hi SignColumn guibg=NONE ctermbg=NONE
    autocmd ColorScheme * hi EndOfBuffer guibg=NONE ctermbg=NONE

    " just use the terminal's background color
    " autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * hi LineNr guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * hi SignColumn guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * hi EndOfBuffer guibg=NONE ctermbg=NONE
augroup END


" rainbow parenthesis
let g:rainbow_active = 1
let g:rainbow_conf = {'guifgs': ['cyan', 'lightmagenta', 'orange', 'lightred']}
