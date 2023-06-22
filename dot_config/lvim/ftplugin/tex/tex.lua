-- " My LaTex settings

vim.opt.wrap = true
vim.g.tex_flavor = "latex"
vim.cmd("call vimtex#init()")

-- vim.api.nvim_create_autocmd({ "VimtexEventViewReverse" }, {
-- 	-- group = "vimtex_event_focus",
-- 	callback = function()
-- 		vim.cmd([[slient execute "!open -a Alacritty"]])
-- 		vim.cmd("redraw!")
-- 	end,
-- })
