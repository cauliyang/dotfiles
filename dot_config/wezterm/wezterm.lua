local wezterm = require("wezterm")
local keys = require("keys")
local platform = require("platform")
local utils = require("utils")
local events = require("events")

-- A helper function for my fallback fonts
local function font_with_fallback(name, params)
	local names = { name, "mini-file-icons", "Hack Nerd Font" }
	return wezterm.font_with_fallback(names, params)
end

local config = {
	check_for_updates = true,
	automatically_reload_config = true,

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

	initial_cols = 128,
	initial_rows = 32,

	use_dead_keys = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = -1,
	},

	window_decorations = "RESIZE",
	enable_scroll_bar = false,

	selection_word_boundary = " \t\n{}[]()\"'`,;:@",
	line_height = 1.25,
	font_size = 15,

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
		-- Linkify things that look like URLs and the host has a TLD name.
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},

		-- linkify email addresses
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},

		-- file:// URI
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\bfile://\S*\b]],
			format = "$0",
		},

		-- Linkify things that look like URLs with numeric addresses as hosts.
		-- E.g. http://127.0.0.1:8000 for a local development server,
		-- or http://192.168.1.1 for the web interface of many routers.
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = "$0",
		},

		-- Make username/project paths clickable. This implies paths like the following are for GitHub.
		-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
		-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
		{
			regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
			format = "https://www.github.com/$1/$3",
		},
	},

	ssh_domains = {
		{
			name = "quest",
			remote_address = "quser33.ci.northwestern.edu",
			username = "ylk4626",
			remote_wezterm_path = "/home/ylk4626/.local/bin/wezterm",
		},
	},
}

return utils.merge_tables(config, platform.config, events.config, keys.config)
