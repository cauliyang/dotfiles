local utils = require("utils")

local M = {}

if utils.is_windows() then
	M.config = {
		window_background_opacity = 0,
		win32_system_backdrop = "Acrylic",
	}
elseif utils.is_mac() then
	M.config = {
		window_background_opacity = 0.6,
		macos_window_background_blur = 20,
	}
end

return M
