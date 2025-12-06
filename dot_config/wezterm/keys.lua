local wezterm = require("wezterm")
local utils = require("utils")

local M = {}

-- https://github.com/yutkat/dotfiles/blob/main/.config/wezterm/keybinds.lua
-- https://github.com/KevinSilvester/wezterm-config/blob/master/config/appearance.lua

M.keys1 = {
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },

	{ key = '"', mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "%", mods = "LEADER", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },

	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "t", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },

	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	-- { key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },

	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },

	{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "w", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },

	{ key = "z", mods = "LEADER", action = "ToggleFullScreen" },
}

M.keys2 = { -- New/close pane
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "X", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) }, -- Pane navigation
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "DownArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "UpArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) }, -- Tab navigation

	{ key = "z", mods = "CMD", action = "TogglePaneZoomState" },
	{ key = "1", mods = "CMD", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "CMD", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "CMD", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "CMD", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "CMD", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "CMD", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "CMD", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "CMD", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "CMD", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "t", mods = "CTRL", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ key = "d", mods = "CTRL", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	{ key = "LeftArrow", mods = "ALT|CMD", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "RightArrow", mods = "ALT|CMD", action = wezterm.action({ ActivateTabRelative = 1 }) }, -- Resize
	{ key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) }, -- Split

	{ key = "-", mods = "CMD", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "\\", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Copy/paste buffer

	-- { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
	-- { key = "]", mods = "LEADER", action = "QuickSelect" },
}

M.pane_key = {
	-- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
	-- mode until we cancel that mode.
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},

	-- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
	-- mode until we press some other key or until 1 second (1000ms)
	-- of time elapses
	{
		key = "a",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "activate_pane",
			timeout_milliseconds = 1000,
		}),
	},

	-- LEADER, followed by 'c' will create pane
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "create_pane",
			timeout_milliseconds = 1000,
		}),
	},
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
}

M.key_tables = {
	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},

	-- Defines the keys that are active in our activate-pane mode.
	-- 'activate_pane' here corresponds to the name="activate_pane" in
	-- the key assignments above.
	activate_pane = {
		{ key = "LeftArrow", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "h", action = wezterm.action.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "l", action = wezterm.action.ActivatePaneDirection("Right") },

		{ key = "UpArrow", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "k", action = wezterm.action.ActivatePaneDirection("Up") },

		{ key = "DownArrow", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	},

	create_pane = {
		{ key = "LeftArrow", action = wezterm.action.SplitPane({ direction = "Left" }) },
		{ key = "h", action = wezterm.action.SplitPane({ direction = "Left" }) },

		{ key = "RightArrow", action = wezterm.action.SplitPane({ direction = "Right" }) },
		{ key = "l", action = wezterm.action.SplitPane({ direction = "Right" }) },

		{ key = "DownArrow", action = wezterm.action.SplitPane({ direction = "Down" }) },
		{ key = "j", action = wezterm.action.SplitPane({ direction = "Down" }) },

		{ key = "UpArrow", action = wezterm.action.SplitPane({ direction = "Up" }) },
		{ key = "k", action = wezterm.action.SplitPane({ direction = "Up" }) },
	},
}

M.config = {
	keys = M.pane_key,
	key_tables = M.key_tables,
	leader = {
		key = "b",
		mods = "CTRL",
	},
}

return M
