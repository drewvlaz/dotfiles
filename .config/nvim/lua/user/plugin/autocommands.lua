function Sad(line_nr, from, to, fname)
  vim.cmd(string.format("silent !sed -i '%ss/%s/%s/' %s", line_nr, from, to, fname))
end

function IncreasePadding()
  Sad('11', 0, 3, '~/.config/alaacrity/alacritty.yml')
  Sad('12', 0, 3, '~/.config/alacritty/alacritty.yml')
end

function DecreasePadding()
  Sad('11', 3, 0, '~/.config/alacritty/alacritty.yml')
  Sad('12', 3, 0, '~/.config/alacritty/alacritty.yml')
end

vim.cmd [[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _code
    autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
    autocmd FileType c,javascript,h setlocal shiftwidth=2
    autocmd FileType latex TSContextDisable
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  " augroup _auto_resize
    " autocmd!
    " autocmd VimResized * tabdo wincmd = 
  " augroup end

  " augroup _alpha
    " autocmd!
    " autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  " augroup end

  augroup qs_colors
      autocmd!
      autocmd ColorScheme * highlight QuickScopePrimary guifg=#ff4af0 gui=underline ctermfg=155 cterm=underline
      autocmd ColorScheme * highlight QuickScopeSecondary guifg=#5fff5f gui=underline ctermfg=81 cterm=underline
  augroup end

  augroup special_formatting
      autocmd!

      " italics for operator mono font
      " autocmd Colorscheme * hi Comment gui=italic cterm=italic
      " autocmd Colorscheme * hi Comment gui=italic cterm=italic guifg=#757590  " better comments for tokyonight
      autocmd Colorscheme * hi String gui=italic cterm=italic
      " autocmd Colorscheme * hi pythonFunctionKeyword gui=italic cterm=italic

      " transparent window
      autocmd ColorScheme * hi Normal ctermbg=none guibg=none
      autocmd ColorScheme * hi NormalNC ctermbg=none guibg=none
      " autocmd ColorScheme * hi CursorLine ctermbg=none guibg=none
      autocmd ColorScheme * hi NonText ctermbg=none guibg=none
      autocmd ColorScheme * hi SignColumn guibg=NONE ctermbg=NONE
      autocmd ColorScheme * hi EndOfBuffer guibg=NONE ctermbg=NONE

      " just use the terminal's background color
      " autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
      " autocmd ColorScheme * hi LineNr guibg=NONE ctermbg=NONE
      " autocmd ColorScheme * hi SignColumn guibg=NONE ctermbg=NONE
      " autocmd ColorScheme * hi EndOfBuffer guibg=NONE ctermbg=NONE
  augroup end

  " augroup ChangeAlacrittyPadding
   " au! 
   " au VimEnter * lua DecreasePadding()
   " au VimLeavePre * lua IncreasePadding()
  " augroup END 

  " augroup file_tree_disable_line
    " autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree_1" | set laststatus=0 | else | set laststatus=2 | endif
  " augroup END

  " augroup copilot_text_color
    " autocmd ColorScheme * highlight CopilotSuggestion guifg=#565f89 ctermfg=8
  " augroup END

  " center screen when entering insert mode
  augroup center_on_insert
    autocmd InsertEnter * norm zz 
  augroup END
]]

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end
