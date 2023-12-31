local M = {}

M.config = function()
    if lvim.builtin.noice.active then
        local found, noice_util = pcall(require, "noice.util")
        if found then
            vim.lsp.handlers["textDocument/signatureHelp"] = noice_util.protect(require("noice.lsp").signature)
        end
    end
    local status_ok, noice = pcall(require, "noice")
    if not status_ok then
        return
    end
    local icons = require("user.icons").icons
    local spinners = require("noice.util.spinners")
    spinners.spinners["mine"] = {
        frames = {
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
            " ",
        },
        interval = 80,
    }
    noice.setup({
        format = {
            spinner = {
                name = "mine",
                hl = "Constant",
            },
        },
        lsp = {
            progress = {
                enabled = lvim.builtin.noice.lsp_progress,
                format = {
                    { "{data.progress.percentage} ", hl_group = "Comment" },
                    { "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
                    { "{data.progress.title} ", hl_group = "Comment" },
                },
                format_done = {},
            },
            hover = { enabled = false },
            signature = { enabled = false, auto_open = { enabled = false } },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        cmdline = {
            format = {
                filter = { pattern = "^:%s*!", icon = icons.term, ft = "sh" },
                IncRename = {
                    pattern = "^:%s*IncRename%s+",
                    icon = icons.rename,
                    conceal = true,
                    opts = {
                        relative = "cursor",
                        size = { min_width = 20 },
                        position = { row = -3, col = 0 },
                        buf_options = { filetype = "text" },
                    },
                },
            },
        },
        views = {
            cmdline_popup = {
                win_options = {
                    winblend = 5,
                    winhighlight = {
                        Normal = "NormalFloat",
                        FloatBorder = "NoiceCmdlinePopupBorder",
                        IncSearch = "",
                        Search = "",
                    },
                    cursorline = false,
                },
                position = {
                    row = "93%",
                    col = "50%",
                },
            },
        },
        popupmenu = {
            enabled = false,
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    find = "%d+L, %d+B",
                },
                view = "mini",
            },
            {
                filter = { event = "msg_show", min_height = 10 },
                view = "split",
                opts = { enter = true },
            },
            {
                filter = { event = "msg_show", kind = "search_count" },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "; before #",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "; after #",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = " lines, ",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "go up one level",
                },
                opts = { skip = true },
            },
            {
                filter = {
                    event = "msg_show",
                    find = "yanked",
                },
                opts = { skip = true },
            },
            {
                filter = { find = "No active Snippet" },
                opts = { skip = true },
            },
            {
                filter = { find = "waiting for cargo metadata" },
                opts = { skip = true },
            },
            {
                filter = { find = "nil" },
                opts = { skip = true },
            },
        },
    })
end

return M
