local wezterm = require("wezterm")
local keys = require("keys")
local gpus = wezterm.gui.enumerate_gpus()
local platform = require("platform")
local utils = require("utils")
local events = require("events")

-- Reload the configuration every ten minutes
wezterm.time.call_after(600, function()
	wezterm.reload_configuration()
end)

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
	local names = { name, "mini-file-icons", "Hack Nerd Font", "SauceCodePro Nerd Font" }
	return wezterm.font_with_fallback(names, params)
end

local config = {
	check_for_updates = true,
	bidi_enabled = true,
	bidi_direction = "AutoLeftToRight",
	color_scheme = utils.get_theme(),
	font = font_with_fallback({
		family = "Cascadia Mono",
		harfbuzz_features = {
			"calt",
			"liga",
			"zero",
			"ss01",
			"-ss04",
		},
	}),

	adjust_window_size_when_changing_font_size = false,
	disable_default_key_bindings = false,
	leader = {
		key = "p",
		mods = "CTRL",
	},

	keys = keys.pane_key,
	key_tables = keys.key_tables,

	initial_cols = 128,
	initial_rows = 32,
	use_dead_keys = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	window_decorations = "RESIZE",

	hide_tab_bar_if_only_one_tab = true,
	show_new_tab_button_in_tab_bar = false,
	-- show_tab_index_in_tab_bar = true,
	tab_bar_at_bottom = false,
	enable_scroll_bar = false,
	use_fancy_tab_bar = false,
	tab_max_width = 24,

	selection_word_boundary = " \t\n{}[]()\"'`,;:@",
	line_height = 1.25,
	font_size = 15,

	bold_brightens_ansi_colors = true,

	webgpu_preferred_adapter = gpus[1],
	front_end = "WebGpu",

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},

	-- This increases color saturation by 50%
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.4,
	},

	hyperlink_rules = {
		{
			regex = [[\b(https|http)://\S*\b]],
			format = "$0",
		},
		{
			regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
			format = "https://www.github.com/$1/$3",
		},
	},
}

return utils.merge_tables(config, platform.config, events.config)
