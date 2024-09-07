--------------------------------------------------------------------------------
-- region SETUP
--------------------------------------------------------------------------------
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- endregion
--------------------------------------------------------------------------------
-- region FONTS
--------------------------------------------------------------------------------
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 18
config.font_rules = {
	{
		italic = true,
		font = wezterm.font("My Mono", { italic = true }),
	},
}

-- endregion
--------------------------------------------------------------------------------
-- region WINDOW
--------------------------------------------------------------------------------
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.77
config.macos_window_background_blur = 50

config.window_padding = {
	left = 20,
	right = 20,
	top = 10,
	bottom = 5,
}

-- endregion
--------------------------------------------------------------------------------
-- region COLORS
--------------------------------------------------------------------------------

-- config.color_scheme = 'Everforest Dark Hard (Gogh)'
config.color_scheme = "Oceanic Next (Gogh)"
-- config.colors = {
-- 	background = "#21282c",
-- }

-- -- From https://www.josean.com/posts/how-to-setup-wezterm-terminal
-- config.colors = {
-- 	foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	cursor_bg = "#47FF9C",
-- 	cursor_border = "#47FF9C",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#CBE0F0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

-- endregion
--------------------------------------------------------------------------------
-- region MISC
--------------------------------------------------------------------------------

-- For Neovim
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- endregion
--------------------------------------------------------------------------------

return config
