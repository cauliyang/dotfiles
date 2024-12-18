local utils = require("utils")
local wezterm = require("wezterm")

local M = {}

if utils.is_windows() then
	M.config = {
		-- https://wezfurlong.org/wezterm/config/lua/config/background.html#parallax-example
		window_background_opacity = 0,
		win32_system_backdrop = "Acrylic",
		font = utils.font_with_fallback({
			family = "Cascadia Code",
			harfbuzz_features = {
				"calt",
				"liga",
				"zero",
				"ss01",
				"ss04",
			},
		}),
	}
elseif utils.is_mac() then
	M.config = {
		window_background_opacity = 0.70,
		macos_window_background_blur = 30,
		font = utils.font_with_fallback({
			family = "Cascadia Code",
			-- family = "JetBrains Mono",
			-- https://monaspace.githubnext.com/
			-- family = "Monaspace Neon",
			-- weight = "Medium",
			harfbuzz_features = {
				"calt",
				"liga",
				"zero",
				"ss01",
				"ss02",
				"ss03",
				"ss04",
				"ss05",
				"ss06",
				"ss07",
				"ss08",
				"ss19",
				"ss20",
				"onum",
				"dlig",
			},
		}),
		-- font_rules = {
		-- 	{
		-- 		intensity = "Bold",
		-- 		italic = true,
		-- 		font = wezterm.font({
		-- 			family = "Victor Mono",
		-- 			weight = "Bold",
		-- 			style = "Italic",
		-- 		}),
		-- 	},
		-- 	{
		-- 		italic = true,
		-- 		intensity = "Half",
		-- 		font = wezterm.font({
		-- 			family = "Victor Mono",
		-- 			weight = "DemiBold",
		-- 			style = "Italic",
		-- 		}),
		-- 	},
		-- 	{
		-- 		italic = true,
		-- 		intensity = "Normal",
		-- 		font = wezterm.font({
		-- 			family = "Victor Mono",
		-- 			style = "Italic",
		-- 		}),
		-- 	},
		-- },
	}
else
	M.config = {
		window_background_opacity = 0.8,
		font = utils.font_with_fallback({
			family = "CaskaydiaCove Nerd Font",
			harfbuzz_features = {
				"calt",
				"liga",
				"zero",
				"ss01",
				"-ss04",
			},
		}),
	}
end

return M
