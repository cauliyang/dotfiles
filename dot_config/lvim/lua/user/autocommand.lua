-- jump to last edit position

vim.api.nvim_create_autocmd("FileType", { pattern = "rust", command = [[inoremap  <buffer> kk -> ]] })
vim.api.nvim_create_autocmd("FileType", { pattern = "rust", command = [[inoremap  <buffer> jj => ]] })

vim.api.nvim_create_autocmd({ "UIEnter" }, {
    callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
            vim.o.laststatus = 0
        end
    end,
})

-- -- firenvim

-- www.overleaf.com_project-64332fa11174832565817f1c_d-editor-DIV-2-DIV-1-DIV-2-DIV-2_2023-04-10T02-43-21-511Z.txt
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "www.overleaf.com_*.txt",
    callback = function()
        vim.cmd("set filetype=tex")
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "typst.app_project-*.txt",
    callback = function()
        vim.cmd("set filetype=typst")
    end,
})

-- highlight zsh file
vim.api.nvim_create_autocmd("FileType", {
    pattern = "zsh",
    callback = function()
        -- let treesitter use bash highlight for zsh files as well
        require("nvim-treesitter.highlight").attach(0, "bash")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tpp",
    callback = function()
        -- let treesitter use bash highlight for zsh files as well
        vim.cmd("set filetype=cpp")
    end,
})

-- https://github.com/voldikss/vim-translator/tree/63ac44f87563fea49cfb5f07379b5959ef19cdaa#know-bugs

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>ct", "<Plug>Translate", { silent = true, noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<localleader>cw", "<Plug>TranslateW", { silent = true, noremap = true })
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            - "o" -- O and o, don't continue comments
            + "r" -- Enter, continue comments
    end,
})

-- Colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    desc = "Apply the custom colorschemes",
    callback = function()
        require("user.theme").telescope_theme()
        require("user.theme").dashboard_theme()
        require("user.icons").define_dap_signs()
    end,
})

-- Cleanup.
vim.api.nvim_clear_autocmds({ pattern = "lir", group = "_filetype_settings" })
vim.api.nvim_clear_autocmds({ pattern = "*", group = "_lvim_colorscheme" })
vim.api.nvim_clear_autocmds({ pattern = "*", group = "nvim_swapfile" })

-- Custom group.
vim.api.nvim_create_augroup("_lvim_user", {})

-- Codelense viewer
vim.api.nvim_create_autocmd("CursorHold", {
    group = "_lvim_user",
    pattern = { "*.rs", "*.c", "*.cpp", "*.go", "*.ts", "*.tsx", "*.kt", "*.py", "*.pyi", "*.java" },
    desc = "Enable and refresh codelens",
    command = "lua require('user.codelens').show_line_sign()",
})

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = "_lvim_user",
    pattern = "term://*",
    desc = "Set terminal keymappings",
    command = "lua require('user.keys').terminal_keys()",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = "_lvim_user",
    pattern = "*.md",
    desc = "Beautify markdown",
    callback = function()
        vim.cmd([[set syntax=markdown textwidth=80]])
        require("user.markdown_syntax").config()
    end,
})

-- Disable colorcolumn
vim.api.nvim_create_autocmd("BufEnter", {
    group = "_lvim_user",
    pattern = "*",
    desc = "Disable the ANNOYING colorcolumn",
    command = "set colorcolumn=",
})

-- Disable undo for certain files
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "_lvim_user",
    pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
    desc = "Disable undo for specific files",
    callback = function()
        vim.opt_local.undofile = false
    end,
})

-- Allow hlslense in scrollbar
vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = "_lvim_user",
    pattern = "*",
    desc = "Allow hlslense in scrollbar",
    command = "lua ok, sb = pcall(require, 'scrollbar.handlers.search'); if ok then sb.handler.hide() end",
})

-- Faster yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "_general_settings",
    pattern = "*",
    desc = "Highlight text on yank",
    callback = function()
        require("vim.highlight").on_yank({ higroup = "Search", timeout = 200 })
    end,
})

-- Prevent entering buffers in insert mode.
vim.api.nvim_create_autocmd("WinLeave", {
    group = "_lvim_user",
    desc = "Prevent entering buffers in insert mode.",
    callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
    end,
})

-- https://github.com/crisidev/dotfiles/blob/main/home/.config/lvim/lua/user/autocmd.lua
