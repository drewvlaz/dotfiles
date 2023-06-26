-- 'unblevable/quick-scope'
-- Trigger a highlight in the appropriate direction when pressing these keys:
vim.g.qs_highlight_on_keys = {"f", "F", "t", "T"}
vim.g.qs_max_chars=150

-- -- "justinmk/vim-sneak"
-- vim.cmd("let g:sneak#label = 1")
-- -- case insensitive
-- vim.cmd("let g:sneak#use_ic_scs = 1")
-- -- immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
-- vim.cmd("let g:sneak#s_next = 1")
-- -- " use space to escape sneak
-- vim.cmd("let g:sneak#label_esc = '<Space>'")
-- -- " set labels to use for matches
-- vim.cmd("let g:sneak#target_labels = ';,fteszxn/FTGAHLTNRMQZ?0'")
-- vim.cmd("let g:sneak#prompt = ''")
-- -- vim.cmd("let g:sneak#prompt = '什'")

-- remap so I can use , and ; with f and t instead
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "gS", "<Plug>Sneak_,", opts)
vim.api.nvim_set_keymap("n", "gs", "<Plug>Sneak_;", opts)

-- " Change the colors
-- vim.cmd [[
--   augroup sneak_colors
--       autocmd!
--       autocmd ColorScheme * hi SneakScope guifg=white guibg=#f1354b ctermfg=black ctermbg=cyan
--       autocmd ColorScheme * hi SneakLabel guifg=black guibg=#b1f548 ctermfg=white ctermbg=green
--   augroup END
-- ]]

local status_ok, leap = pcall(require, "leap")
if not status_ok then
	return
end
leap.add_default_mappings()
