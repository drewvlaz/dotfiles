" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#575f65'
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

let g:goyo_width = 120

function! s:goyo_enter()
  " prevent lines from getting cut off
  norm mq
  norm 0
  norm `q
  norm :delmarks q

  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

