" label matches
let g:sneak#label = 1
" case insensitive sneak
let g:sneak#use_ic_scs = 1
" immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1
" use space to escape sneak
let g:sneak#label_esc = "\<Space>" 
" set labels to use for matches
let g:sneak#target_labels = ";fjkasgh/FJTGAHLTNRMQZ?0" 

" remap so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;

" Change the colors
augroup sneak_colors
    autocmd!
    autocmd ColorScheme * hi SneakScope guifg=white guibg=#f1354b ctermfg=black ctermbg=cyan
    autocmd ColorScheme * hi SneakLabel guifg=black guibg=#b1f548 ctermfg=white ctermbg=green
augroup END

" Cool prompt
" let g:sneak#prompt = '什'

" I like quickscope better for this since it keeps me in the scope of a single line
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T
