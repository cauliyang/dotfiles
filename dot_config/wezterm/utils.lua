local wezterm = require("wezterm")

local M = {}

function M.font_with_fallback(name, params)
	local names = { name, "FiraCode Nerd Font", "mini-file-icons", "Hack Nerd Font" }
	return wezterm.font_with_fallback(names, params)
end

function M.get_theme()
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

M.extend_tables = function(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
end

M.merge_tables = function(t1, ...)
	local args = { ... }

	for _, t2 in ipairs(args) do
		for k, v in pairs(t2) do
			if (type(v) == "table") and (type(t1[k] or false) == "table") then
				M.merge_tables(t1[k], t2[k])
			else
				t1[k] = v
			end
		end
	end

	return t1
end

M.get_os_name = function()
	-- Return two strings describing the OS name and OS architecture.
	-- For Windows, the OS identification is based on environment variables
	-- On unix, a call to uname is used.
	--
	-- OS possible values: Windows, Linux, Mac, BSD, Solaris
	-- Arch possible values: x86, x86864, powerpc, arm, mips
	--
	-- On Windows, detection based on environment variable is limited
	-- to what Windows is willing to tell through environement variables. In particular
	-- 64bits is not always indicated so do not rely hardly on this value.

	local raw_os_name, raw_arch_name = "", ""

	-- LuaJIT shortcut
	if jit and jit.os and jit.arch then
		raw_os_name = jit.os
		raw_arch_name = jit.arch
	else
		if package.config:sub(1, 1) == "\\" then
			-- Windows
			local env_OS = os.getenv("OS")
			local env_ARCH = os.getenv("PROCESSOR_ARCHITECTURE")
			if env_OS and env_ARCH then
				raw_os_name, raw_arch_name = env_OS, env_ARCH
			end
		else
			raw_os_name = io.popen("uname -s", "r"):read("*l")
			raw_arch_name = io.popen("uname -m", "r"):read("*l")
		end
	end

	raw_os_name = (raw_os_name):lower()
	raw_arch_name = (raw_arch_name):lower()

	local os_patterns = {
		["windows"] = "Windows",
		["linux"] = "Linux",
		["osx"] = "Mac",
		["mac"] = "Mac",
		["darwin"] = "Mac",
		["^mingw"] = "Windows",
		["^cygwin"] = "Windows",
		["bsd$"] = "BSD",
		["sunos"] = "Solaris",
	}

	local arch_patterns = {
		["^x86$"] = "x86",
		["i[%d]86"] = "x86",
		["amd64"] = "x86_64",
		["x86_64"] = "x86_64",
		["x64"] = "x86_64",
		["power macintosh"] = "powerpc",
		["^arm"] = "arm",
		["^mips"] = "mips",
		["i86pc"] = "x86",
	}

	local os_name, arch_name = "unknown", "unknown"

	for pattern, name in pairs(os_patterns) do
		if raw_os_name:match(pattern) then
			os_name = name
			break
		end
	end
	for pattern, name in pairs(arch_patterns) do
		if raw_arch_name:match(pattern) then
			arch_name = name
			break
		end
	end
	return os_name, arch_name
end

M.is_mac = function()
	local os_name, _ = M.get_os_name()
	return os_name == "Mac"
end

M.is_linux = function()
	local os_name, _ = M.get_os_name()
	return os_name == "Linux"
end

M.is_windows = function()
	local os_name, _ = M.get_os_name()
	return os_name == "Windows"
end

return M
