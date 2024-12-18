local M = {}

M.config = function()
    vim.cmd("function! TbToggle_theme(a,b,c,d) \n lua require('user.theme').toggle_theme() \n endfunction")
    vim.cmd("function! Quit_vim(a,b,c,d) \n qa \n endfunction")

    local icons = require("user.icons").icons
    local List = require("plenary.collections.py_list")
    lvim.builtin.bufferline.highlights = {
        fill = {
            bg = {
                attribute = "bg",
                highlight = "NormalNC",
            },
        },
        background = { italic = true },
        buffer_selected = { bold = true },
    }

    local g_ok, bufferline_groups = pcall(require, "bufferline.groups")
    if not g_ok then
        bufferline_groups = {
            builtin = {
                pinned = {
                    name = "pinned",
                    with = function(_) end,
                },
                ungroupued = { name = "ungrouped" },
            },
        }
    end

    lvim.builtin.bufferline.options = {
        navigation = { mode = "uncentered" },
        diagnostics = false,
        diagnostics_indicator = function(_, _, diagnostics, _)
            local result = {}
            local symbols = { error = icons.error, warning = icons.warn }
            for name, count in pairs(diagnostics) do
                if symbols[name] and count > 0 then
                    table.insert(result, symbols[name] .. count)
                end
            end
            local res = table.concat(result, " ")
            return #res > 0 and res or ""
        end,
        mode = "buffers",
        sort_by = "insert_after_current",
        always_show_bufferline = false,
        groups = {
            options = {
                toggle_hidden_on_enter = true,
            },
            items = {
                bufferline_groups.builtin.pinned:with({ icon = icons.pinned }),
                bufferline_groups.builtin.ungrouped,
                M.language_files("rust", "rs"),
                M.language_files("python", "py"),
                M.language_files("kotlin", "kt"),
                M.language_files("java", "java"),
                M.language_files("lua", "lua"),
                M.language_files("ruby", "rb"),
                M.language_files("smithy", "smithy"),
                M.language_files("go", "go"),
                M.language_files("c", "c"),
                M.language_files("cpp", "cpp"),
                {
                    name = "tests",
                    icon = icons.test,
                    matcher = function(buf)
                        return vim.api.nvim_buf_get_name(buf.id):match("_spec")
                            or vim.api.nvim_buf_get_name(buf.id):match("test_")
                    end,
                },
                {
                    name = "docs",
                    matcher = function(buf)
                        local list = List({ "md", "org", "norg", "wiki", "rst", "txt" })
                        return list:contains(vim.fn.fnamemodify(buf.path, ":e"))
                    end,
                },
                {
                    name = "cfg",
                    matcher = function(buf)
                        return vim.api.nvim_buf_get_name(buf.id):match("go.mod")
                            or vim.api.nvim_buf_get_name(buf.id):match("go.sum")
                            or vim.api.nvim_buf_get_name(buf.id):match("Cargo.toml")
                            or vim.api.nvim_buf_get_name(buf.id):match("manage.py")
                            or vim.api.nvim_buf_get_name(buf.id):match("config.toml")
                            or vim.api.nvim_buf_get_name(buf.id):match("setup.py")
                            or vim.api.nvim_buf_get_name(buf.id):match("Makefile")
                            or vim.api.nvim_buf_get_name(buf.id):match("Config")
                            or vim.api.nvim_buf_get_name(buf.id):match("gradle.properties")
                            or vim.api.nvim_buf_get_name(buf.id):match("build.gradle.kts")
                            or vim.api.nvim_buf_get_name(buf.id):match("settings.gradle.kts")
                    end,
                },
                {
                    name = "terms",
                    auto_close = true,
                    matcher = function(buf)
                        return buf.path:match("term://") ~= nil
                    end,
                },
            },
        },
        hover = { enabled = true, reveal = { "close" } },
        offsets = {
            {
                text = "EXPLORER",
                filetype = "neo-tree",
                highlight = "PanelHeading",
                text_align = "left",
                separator = true,
            },
            {
                text = " FLUTTER OUTLINE",
                filetype = "flutterToolsOutline",
                highlight = "PanelHeading",
                separator = true,
            },
            {
                text = "UNDOTREE",
                filetype = "undotree",
                highlight = "PanelHeading",
                separator = true,
            },
            {
                text = "󰇚 LAZY",
                filetype = "lazy",
                highlight = "PanelHeading",
                separator = true,
            },
            {
                text = "󰆼 DATABASE VIEWER",
                filetype = "dbui",
                highlight = "PanelHeading",
                separator = true,
            },
            {
                text = " DIFF VIEW",
                filetype = "DiffviewFiles",
                highlight = "PanelHeading",
                separator = true,
            },
        },
        separator_style = vim.env.KITTY_WINDOW_ID and "slant" or "thin",
        right_mouse_command = "vert sbuffer %d",
        show_close_icon = false,
        indicator = {
            -- icon = "⭐", -- this should be omitted if indicator style is not 'icon'
            style = "none", -- can also be 'underline'|'none',
        },
        max_name_length = 18,
        max_prefix_length = 10, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        color_icons = true,
        diagnostics_update_in_insert = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
    }
end

M.language_files = function(name, extension)
    local opts = {
        name = name,
        matcher = function(buf)
            return vim.fn.fnamemodify(buf.path, ":e") == extension
        end,
    }
    return opts
end

M.delete_buffer = function()
    local fn = vim.fn
    local cmd = vim.cmd
    local buflisted = fn.getbufinfo({ buflisted = 1 })
    local cur_winnr, cur_bufnr = fn.winnr(), fn.bufnr()
    if #buflisted < 2 then
        cmd("bd!")
        return
    end
    for _, winid in ipairs(fn.getbufinfo(cur_bufnr)[1].windows) do
        cmd(string.format("%d wincmd w", fn.win_id2win(winid)))
        cmd(cur_bufnr == buflisted[#buflisted].bufnr and "bp" or "bn")
    end
    cmd(string.format("%d wincmd w", cur_winnr))
    local is_terminal = fn.getbufvar(cur_bufnr, "&buftype") == "terminal"
    cmd(is_terminal and "bd! #" or "silent! confirm bd #")
end

return M
