-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local function whichkey_opts(description)
  return vim.tbl_extend("keep", { desc = description }, opts)
end

-- Easier Escape --
keymap("i", "jk", "<ESC>", opts)
-- keymap("i", "kj", "<ESC>", opts)
keymap("i", "<C-c>", "<ESC>", opts)

-- Vertical movement --
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Better indenting, stay in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Override lazyvim file and buffer search
-- keymap("n", "<leader>f", ":Telescope find_files<CR>", whichkey_opts("Find files"))
-- keymap("n", "<leader>b", ":Telescope buffers<CR>", whichkey_opts("Find buffers"))

-- Navigate buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)
keymap("n", "<S-TAB>", ":bprevious<CR>", opts)
keymap("n", "<BACKSPACE>", "<C-^>", opts)

-- Harpoon
keymap("n", "<leader>hA", require("harpoon.mark").add_file, whichkey_opts("Add file"))
keymap("n", "<leader>hv", require("harpoon.ui").toggle_quick_menu, whichkey_opts("View files"))
for i = 1, 9 do
  keymap("n", string.format("<leader>h%s", string.char(96 + i)), function()
    require("harpoon.ui").nav_file(i)
  end, whichkey_opts(string.format("Goto file %d", i)))
end

-- Copilot
keymap("i", "<C-l>", "copilot#Accept()", vim.tbl_extend("keep", { expr = true, replace_keycodes = false }, opts))

-- Go forward in jump list, apparently <C-i> and <TAB> are the same to terminal
keymap("n", "<C-n>", "<C-i>", opts)

-- Vimtex
keymap("n", "<leader>dc", "<cmd>VimtexCompile<CR>", whichkey_opts("Compile"))
keymap("n", "<leader>df", "<cmd>VimtexClean<CR>", whichkey_opts("Clean"))
-- keymap("n", "<leader>de", "<cmd>VimtexErrors<CR>", whichkey_opts("Errors"))
keymap("n", "<leader>ds", "<cmd> set spell! spell?<CR>", whichkey_opts("Toggle spelling"))
-- f = { "<cmd>LspZeroFormat<CR>", "Format"},
-- s = { "<cmd>set spell! spell?<CR>", "Toggle spelling"},
-- S = { "z=", "Spell suggestions"},
-- m = { "ciW$$<ESC>P", "Format math"},

-- c = {
--       "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<CR>",
--       "Colorscheme with Preview",
-- },
