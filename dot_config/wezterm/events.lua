local wezterm = require("wezterm")
local colors = require("colors")

local M = {}

local random_color = colors.random_color()
local color_primary = random_color
local title_color_bg = color_primary.bg
local title_color_fg = color_primary.fg

wezterm.on("update-right-status", function(window)
	local table_name = ""
	if window:active_key_table() then
		table_name = window:active_key_table()
	end

	local time = wezterm.strftime("%-l:%M %P")

	local bg1 = title_color_bg:lighten(0.1)
	local bg2 = title_color_bg:lighten(0.2)

	window:set_right_status(wezterm.format({
		{ Background = { Color = title_color_bg } },
		{ Foreground = { Color = bg1 } },
		{ Text = "" },
		{ Background = { Color = title_color_bg:lighten(0.1) } },
		{ Foreground = { Color = title_color_fg } },
		{ Text = " " .. window:active_workspace() .. " " },
		{ Foreground = { Color = bg1 } },
		{ Background = { Color = bg2 } },
		{ Text = "" },
		{ Foreground = { Color = title_color_bg:lighten(0.4) } },
		{ Foreground = { Color = title_color_fg } },
		{ Text = " " .. time .. " " .. table_name },
	}))
end)

wezterm.on("gui-startup", function(cmd)
	local mux = wezterm.mux

	local tab, pane, window = mux.spawn_window(cmd or {
		workspace = "default",
	})

	local icons = {
		"🌞",
		"🍧",
		"🫠",
		"🏞️",
		"📑",
		"🪁",
		"🧠",
		"🦥",
		"🦉",
		"📀",
		"🌮",
		"🍜",
		"🧋",
		"🥝",
		"🍊",
	}

	tab:set_title("  " .. icons[math.random(#icons)] .. "  ")
end)

local TAB_EDGE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
local TAB_EDGE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick

local function tab_title(tab_info)
	local title = tab_info.tab_title

	if title and #title > 0 then
		return title
	end

	return tab_info.active_pane.title:gsub("%.exe", "")
end

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
	local edge_background = title_color_bg
	local background = title_color_bg:lighten(0.05)
	local foreground = title_color_fg

	if tab.is_active then
		background = background:lighten(0.1)
		foreground = foreground:lighten(0.1)
	elseif hover then
		background = background:lighten(0.2)
		foreground = foreground:lighten(0.2)
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = TAB_EDGE_LEFT },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = TAB_EDGE_RIGHT },
	}
end)

M.config = {
	colors = {
		tab_bar = {
			background = title_color_bg,
			active_tab = {
				bg_color = title_color_bg:lighten(0.03),
				fg_color = title_color_fg:lighten(0.8),
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = title_color_bg:lighten(0.01),
				fg_color = title_color_fg,
				intensity = "Half",
			},
			inactive_tab_edge = title_color_bg,
		},
		split = title_color_bg:lighten(0.3):desaturate(0.5),
	},

	window_frame = {
		active_titlebar_bg = title_color_bg,
		inactive_titlebar_bg = title_color_bg,
		font_size = 14.0,
	},
}

return M
