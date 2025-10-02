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
config.font_size = 13.5

config.color_scheme = "catppuccin-macchiato"
-- config.color_scheme = "Tokyo Night Moon"

config.enable_tab_bar = false

-- config.window_decorations = "NONE"

-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 10

-- Finally, return the configuration to wezterm:
return config
