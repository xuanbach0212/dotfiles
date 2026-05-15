-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Symbols Nerd Font Mono",
})

-- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 11.5

config.color_scheme = "catppuccin-mocha"

-- Invert colors at cursor so the character inside is always visible
config.force_reverse_video_cursor = true
-- config.color_scheme = "Tokyo Night Moon"

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.native_macos_fullscreen_mode = false
-- config.window_decorations = "NONE"

config.window_background_opacity = 0.95
-- config.macos_window_background_blur = 10

-- Finally, return the configuration to wezterm:

-- setup wsl if windows
if wezterm.target_triple:find("windows") then
	for _, domain in ipairs(wezterm.default_wsl_domains()) do
		config.default_domain = domain.name
		config.default_cwd = "~"
		break
	end
end

return config
