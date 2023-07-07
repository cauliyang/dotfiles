local utils = require("utils")

local M = {}

if utils.is_windows() then
	M.config = {
		-- https://wezfurlong.org/wezterm/config/lua/config/background.html#parallax-example
		window_background_opacity = 0,
		win32_system_backdrop = "Acrylic",
	}
elseif utils.is_mac() then
	M.config = {
		window_background_opacity = 0.55,
		macos_window_background_blur = 20,
	}
else
	M.config = {
		window_background_opacity = 0.55,
	}
end

return M
