local wezterm = require("wezterm")
local keys = require("keys")
local gpus = wezterm.gui.enumerate_gpus()
local platform = require("platform")
local utils = require("utils")

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

-- Reload the configuration every ten minutes
wezterm.time.call_after(600, function()
	wezterm.reload_configuration()
end)

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
	local names = { name, "mini-file-icons", "Hack Nerd Font", "SauceCodePro Nerd Font" }
	return wezterm.font_with_fallback(names, params)
end

local function get_theme()
	local _time = os.date("*t")
	if _time.hour >= 1 and _time.hour < 9 then
		return "Rosé Pine (base16)"
	elseif _time.hour >= 9 and _time.hour < 17 then
		return "nightfox"
	elseif _time.hour >= 17 and _time.hour < 21 then
		return "Catppuccin Mocha"
	elseif _time.hour >= 21 and _time.hour < 24 or _time.hour >= 0 and _time.hour < 1 then
		return "kanagawabones"
	end
end

local scheme = wezterm.get_builtin_color_schemes()[get_theme()]
local config = {
	check_for_updates = true,
	bidi_enabled = true,
	bidi_direction = "AutoLeftToRight",
	color_scheme = get_theme(),
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
	show_tab_index_in_tab_bar = true,
	tab_bar_at_bottom = false,
	enable_scroll_bar = false,
	use_fancy_tab_bar = false,
	tab_max_width = 24,

	selection_word_boundary = " \t\n{}[]()\"'`,;:@",
	line_height = 1.25,
	font_size = 14,

	bold_brightens_ansi_colors = true,

	webgpu_preferred_adapter = gpus[1],
	front_end = "WebGpu",

	colors = {
		tab_bar = {
			background = scheme.background,
			new_tab = { bg_color = "#2e3440", fg_color = scheme.ansi[8], intensity = "Bold" },
			new_tab_hover = { bg_color = scheme.ansi[1], fg_color = scheme.brights[8], intensity = "Bold" },
			-- format-tab-title
			active_tab = { bg_color = "#121212", fg_color = "#FCE8C3" },
			inactive_tab = { bg_color = scheme.background, fg_color = "#FCE8C3" },
			inactive_tab_hover = { bg_color = scheme.ansi[1], fg_color = "#FCE8C3" },
		},
	},

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},
	-- This increases color saturation by 50%
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.5,
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

return utils.merge_tables(config, platform.config)
