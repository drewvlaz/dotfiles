-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.font = wezterm.font("CaskaydiaCove Nerd Font")
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 18
config.font_rules = {
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font_with_fallback({
			family = "CaskaydiaCove Nerd Font Italic",
		}),
	},
}

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.82
config.macos_window_background_blur = 0

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

-- Send <C-i> instead of <Tab> to the terminal
-- config.keys = {
-- 	{ key = "i", mods = "CTRL", action = wezterm.action({ SendString = "^N" }) },
-- }

return config
