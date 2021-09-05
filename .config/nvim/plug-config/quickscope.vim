" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg=#ff33f8 gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg=#9fff5f gui=underline ctermfg=81 cterm=underline
augroup END

let g:qs_max_chars=150
