-- source: https://github.com/barreiroleo/nvim-config/blob/master/lua/configs/servers/texlab_cmd.lua

local M = {}
local CMD = {}

-- TODO: Probar, encontrado para zathura:
-- set synctex true
-- set synctex-editor-command "nvim --remote-silent +%{line} %{input}"
CMD.cmd_backsearch = function(file, line, CR_char)
	local cmd = "nvim --server /tmp/nvim.latex --remote-send "
		.. string.format('":lua DROP_TEX(%s,%s)%s"', file, line, CR_char)
	-- local cmd = string.format("zenity --info --text=\"%s %s %s %s %s\"","%f","%l", "%p", file, line)
	-- local cmd = string.format("zenity --info --text=\":lua DROP_TEX(%s,%s)\r\"",file, line)
	-- %f = tex, %l = line, %p = pdf
	return cmd
end

-- CMD.evincesyn = {
--     executable = "evince-synctex",
--     args = { "-f", "%l", "%p", CMD.cmd_backsearch("%f", "%l", "\r") }
-- }

-- CMD.evincesyn = {
--     executable = "/home/leonardo/develop/tools/sved/ftplugin/evinceSync.py",
--     args = { "%p", "%l 0", "%f" }
-- }

CMD.evincesyn = {
	executable = "evince-synctex",
	args = { "--forward", "%l", "--pdffile", "%p", "--texfile", "%f", "--cmd", CMD.cmd_backsearch("%f", "%l", "\r") },
}

CMD.zathura = {
	executable = "zathura",
	args = { "-x", CMD.cmd_backsearch("'%{input}'", "%{line}", "<CR>"), "--synctex-forward", "%l:1:%f", "%p" },
}

CMD.sioyek = {
	executable = "sioyek",
	args = {
		"--inverse-search",
		CMD.cmd_backsearch("'%1'", "%2", "\r"), -- %1 file, %2 line
		"--forward-search-file",
		"%f",
		"--forward-search-line",
		"%l",
		"%p",
	},
}

CMD.latexmk = {
	executable = "latexmk",
	args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-output-directory=../build" },
	forwardSearchAfter = true,
	onSave = true,
}

CMD.tectonic = {

	executable = "tectonic",
	args = { "-X", "compile", "%f", "--keep-logs", "--keep-intermediates", "--synctex", "--outdir build" },

	forwardSearchAfter = false,
	onSave = true,
}

M.forwardSearch = CMD.sioyek
M.build = CMD.latexmk

return M
