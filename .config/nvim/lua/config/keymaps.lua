-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---------------
--- GENERAL ---
---------------

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
keymap("n", "<leader>br", "<cmd>b #<CR>", whichkey_opts("Return to last buffer"))

-- Go forward in jump list, apparently <C-i> and <TAB> are the same to terminal
keymap("n", "<C-n>", "<C-i>", opts)

-- Source
keymap("n", "<leader>S", "<cmd>source $MYVIMRC<CR>", whichkey_opts("Source vimrc"))

---------------
--- PLUGINS ---
---------------

-- Copilot --
keymap("i", "<C-l>", "copilot#Accept()", vim.tbl_extend("keep", { expr = true, replace_keycodes = false }, opts))

-- Code coverage --
keymap("n", "<leader>cc", "<cmd>Coverage<CR>", whichkey_opts("Enable code coverage"))
keymap("n", "<leader>Cs", "<cmd>Coverage<CR>", whichkey_opts("Show code coverage summary"))
keymap("n", "<leader>Ct", "<cmd>CoverageToggle<CR>", whichkey_opts("Toggle code coverage"))

-- Git --
keymap("n", "<leader>ga", "<cmd>GitBlameToggle<CR>", whichkey_opts("Toggle author blame"))
keymap("n", "<leader>gb", "<cmd>GitBlameOpenCommitURL<CR>", whichkey_opts("Open in browser"))

-- Harpoon --
local harpoon = require("harpoon")
local current_branch = function()
  local pipe = io.popen("git branch --show-current")
  local buffer_size = 1024
  if not pipe then
    return
  end

  local branch_name = pipe:read(buffer_size)
  pipe:close()
  return branch_name
end
local toggle_opts = {
  border = "rounded",
  title_pos = "center",
  ui_width_ratio = 0.60,
}
harpoon:setup()
keymap("n", "<leader>hA", function()
  harpoon:list(current_branch()):add()
end, whichkey_opts("Add file"))
keymap("n", "<leader>hv", function()
  harpoon.ui:toggle_quick_menu(harpoon:list(current_branch()), toggle_opts)
end, whichkey_opts("View files"))

for i = 1, 9 do
  keymap("n", string.format("<leader>h%s", string.char(96 + i)), function()
    harpoon:list(current_branch()):select(i)
  end, whichkey_opts(string.format("Goto file %d", i)))
end

-- Vimtex --
-- keymap("n", "<leader>dc", "<cmd>VimtexCompile<CR>", whichkey_opts("Compile"))
-- keymap("n", "<leader>df", "<cmd>VimtexClean<CR>", whichkey_opts("Clean"))
-- keymap("n", "<leader>de", "<cmd>VimtexErrors<CR>", whichkey_opts("Errors"))
-- keymap("n", "<leader>ds", "<cmd> set spell! spell?<CR>", whichkey_opts("Toggle spelling"))

-- Zenmode --
keymap("n", "<leader>z", "<cmd>ZenMode<CR>", whichkey_opts("Toggle zen mode"))
