-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

--------------------------------------------------------------------------------
-- region GENERAL
--------------------------------------------------------------------------------

local M = {}

M.opts = { noremap = true, silent = true }
M.keymap = function(mode, key, action, opts)
  if opts == nil then
    opts = M.opts
  else
    opts = vim.tbl_extend("keep", M.opts, opts)
  end
  vim.keymap.set(mode, key, action, opts)
end

M.which_keymap = function(mode, key, action, description)
  local opts = vim.tbl_extend("keep", M.opts, { desc = description })
  M.keymap(mode, key, action, opts)
end

-- Easier Escape --
M.keymap("i", "jk", "<ESC>")
-- keymap("i", "kj", "<ESC>", opts)
M.keymap("i", "<C-c>", "<ESC>")

-- Vertical movement --
M.keymap("n", "<C-u>", "<C-u>zz")
M.keymap("n", "<C-d>", "<C-d>zz")

-- Better indenting, stay in visual mode
M.keymap("v", "<", "<gv")
M.keymap("v", ">", ">gv")

-- Override lazyvim file and buffer search
-- keymap("n", "<leader>f", ":Telescope find_files<CR>", whichkey_opts("Find files"))
-- keymap("n", "<leader>b", ":Telescope buffers<CR>", whichkey_opts("Find buffers"))

-- Navigate buffers
M.keymap("n", "<TAB>", ":bnext<CR>")
M.keymap("n", "<S-TAB>", ":bprevious<CR>")
M.keymap("n", "<BACKSPACE>", "<C-^>")
M.which_keymap("n", "<leader>br", "<cmd>b #<CR>", "Return to last buffer")

-- Go forward in jump list, apparently <C-i> and <TAB> are the same to terminal
M.keymap("n", "<C-n>", "<C-i>")

-- Source
M.which_keymap("n", "<leader>S", "<cmd>source $MYVIMRC<CR>", "Source vimrc")

-- Windows
M.keymap("n", "<M-K>", ":resize +2<CR>")
M.keymap("n", "<M-J>", ":resize -2<CR>")
M.keymap("n", "<M-H>", ":vertical resize -2<CR>")
M.keymap("n", "<M-L>", ":vertical resize +2<CR>")

return M

-- endregion
--------------------------------------------------------------------------------
