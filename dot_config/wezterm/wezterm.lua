local wezterm = require("wezterm")
local gpus = wezterm.gui.enumerate_gpus()

local padding = {
	left = 0,
	right = 0,
	top = 0.5,
	bottom = 0,
}

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
		-- return "tokyonight_night"
		return "nightfox"
	elseif _time.hour >= 17 and _time.hour < 21 then
		return "Catppuccin Mocha"
	elseif _time.hour >= 21 and _time.hour < 24 or _time.hour >= 0 and _time.hour < 1 then
		return "kanagawabones"
	end
end

local scheme = wezterm.get_builtin_color_schemes()[get_theme()]
local config = {
	bidi_enabled = true,
	bidi_direction = "AutoLeftToRight",
	color_scheme = get_theme(),
	font = font_with_fallback({
		-- family = "FiraCode Nerd Font Mono",
		family = "Cascadia Code",
		harfbuzz_features = {
			"calt",
			"liga",
			"zero",
			"ss01",
			"-ss04",
		},
	}),
	-- leader = { key = "a", mods = "CTRL" },
	-- keys = {
	-- 	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	-- 	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
	-- 	{ key = "\"", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	-- 	{ key = "%", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	-- 	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	-- 	{ key = "t", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	-- 	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	-- 	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	-- 	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	-- 	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	-- 	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	-- 	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	-- 	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	-- 	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
	-- 	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	-- 	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	-- 	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	-- 	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	-- 	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	-- 	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	-- 	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	-- 	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	-- 	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	-- 	{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	-- 	{ key = "w", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	-- 	-- { key = "z", mods = "LEADER", action = "ToggleFullScreen" },
	-- },

	initial_cols = 128,
	initial_rows = 32,
	use_dead_keys = false,
	window_padding = padding,
	window_decorations = "RESIZE",
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	enable_scroll_bar = false,
	use_fancy_tab_bar = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:@",
	-- disable_default_key_bindings = true,
	line_height = 1.25,
	font_size = 14,
	window_background_opacity = 0.8,
	bold_brightens_ansi_colors = true,
	-- swap_backspace_and_delete = false,
	-- term = "wezterm",
	-- freetype_load_target = "Light",
	automatically_reload_config = true,
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
}

return config
