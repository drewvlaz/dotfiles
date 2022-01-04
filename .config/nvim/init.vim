"                           _
"    ____  ___  ____ _   __(_)___ ___
"   / __ \/ _ \/ __ \ | / / / __ `__ \
"  / / / /  __/ /_/ / |/ / / / / / / /
" /_/ /_/\___/\____/|___/_/_/ /_/ /_/
"

" ----- PACKAGE MANAGER -----
luafile ~/.config/nvim/lua/plugins.lua
luafile ~/.config/nvim/lua/options.lua

" ----- PACKAGES -----
source ~/.config/nvim/plug-config/goyo.vim
source ~/.config/nvim/plug-config/coc.vim
source ~/.config/nvim/plug-config/sneak.vim
source ~/.config/nvim/plug-config/quickscope.vim
" source ~/.config/nvim/plug-config/startify.vim
source ~/.config/nvim/plug-config/vimtex.vim
source ~/.config/nvim/plug-config/neovide.vim
luafile ~/.config/nvim/plug-config/telescope.lua
luafile ~/.config/nvim/plug-config/bufferline.lua
luafile ~/.config/nvim/plug-config/dashboard.lua
luafile ~/.config/nvim/plug-config/nvimtree.lua
luafile ~/.config/nvim/plug-config/treesitter.lua

" ----- THEMES -----
source ~/.config/nvim/themes/theme.vim
source ~/.config/nvim/themes/airline.vim

" ----- BASIC OPTIONS ---
source ~/.config/nvim/general/settings.vim

" ----- KEYBINDINGS -----
source ~/.config/nvim/general/keys.vim

