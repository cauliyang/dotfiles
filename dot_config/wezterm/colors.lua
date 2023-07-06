local wezterm = require("wezterm")

local M = {}

local color_default_fg_light = wezterm.color.parse("#cacaca") -- 💩
local color_default_fg_dark = wezterm.color.parse("#303030")

M.colors = {
	VERIDIAN = {
		bg = wezterm.color.parse("#4D8060"),
		fg = color_default_fg_light,
	},
	PAYNE = {
		bg = wezterm.color.parse("#385F71"),
		fg = color_default_fg_light,
	},
	INDIGO = {
		bg = wezterm.color.parse("#7C77B9"),
		fg = color_default_fg_light,
	},
	CAROLINA = {
		bg = wezterm.color.parse("#8FBFE0"),
		fg = color_default_fg_dark,
	},
	FLAME = {
		bg = wezterm.color.parse("#D36135"),
		fg = color_default_fg_dark,
	},
	JET = {
		bg = wezterm.color.parse("#282B28"),
		fg = color_default_fg_light,
	},
	TAUPE = {
		bg = wezterm.color.parse("#785964"),
		fg = color_default_fg_light,
	},
	ECRU = {
		bg = wezterm.color.parse("#C6AE82"),
		fg = color_default_fg_dark,
	},
	VIOLET = {
		bg = wezterm.color.parse("#685F74"),
		fg = color_default_fg_light,
	},
	VERDIGRIS = {
		bg = wezterm.color.parse("#28AFB0"),
		fg = color_default_fg_light,
	},
}

function M.random_color()
	local colors = {}
	for _, v in pairs(M.colors) do
		table.insert(colors, v)
	end
	return colors[math.random(#colors)]
end

return M
