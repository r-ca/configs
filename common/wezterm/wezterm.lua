-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.automatically_reload_config = true

config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }

config.font = wezterm.font_with_fallback {
	'JetBrainsMonoNL Nerd Font',
	'Koruri',
}

config.font_size = 11.5

wezterm.on('window-config-reloaded', function(window, pane)
  wezterm.log_info 'the config was reloaded for this window!'
end)

config.color_scheme = 'Ashes (light) (terminal.sexy)'

-- and finally, return the configuration to wezterm
return config


