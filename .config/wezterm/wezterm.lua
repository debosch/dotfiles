local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
	local screen = wezterm.gui.screens().main
	local ratio = 0.7
	local heightRatio = 0.8
	local width, height = screen.width * ratio, screen.height * ratio
	local _, _, window = wezterm.mux.spawn_window(cmd or {
		position = { x = (screen.width - width) / 2, y = (screen.height - height) / 2 },
	})
	-- window:gui_window():maximize()
	window:gui_window():set_inner_size(width, height * heightRatio)
end)

local config = wezterm.config_builder()

config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Bold" })
config.color_scheme = "rose-pine"
config.font_size = 21
config.automatically_reload_config = true
config.keys = {
	{
		key = "w",
		mods = "SUPER",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.hide_tab_bar_if_only_one_tab = true

return config
