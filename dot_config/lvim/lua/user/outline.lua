local M = {}

M.config = function()
    local status_ok, outline = pcall(require, "outline")
    if not status_ok then
        return
    end

    ---@diagnostic disable-next-line
    local opts = {
        guides = {
            enabled = true,
        },
        keymaps = {
            close = { "<Esc>", "q" },
            code_actions = "a",
            fold = "h",
            fold_all = "W",
            fold_reset = "R",
            goto_location = "<Cr>",
            hover_symbol = "<C-space>",
            peek_location = "o",
            rename_symbol = "r",
            toggle_preview = "K",
            unfold = "l",
            unfold_all = "E",
        },
        outline_items = {
            highlight_hovered_item = true,
            show_symbol_details = true,
        },
        outline_window = {
            auto_close = false,
            position = "right",
            relative_width = true,
            show_numbers = false,
            show_relative_numbers = false,
            width = 25,
            wrap = false,
        },
        preview_window = {
            auto_preview = false,
            winhl = "Normal:Pmenu",
        },
        provider = {
            lsp = {
                blacklist_clients = {},
            },
        },
        symbol_folding = {
            auto_unfold_hover = true,
        },
        symbols = {
            icons = {
                Array = { hl = "@constant", icon = "" },
                Boolean = { hl = "@boolean", icon = "" },
                Class = { hl = "@type", icon = "" },
                Component = { hl = "@function", icon = "" },
                Constant = { hl = "@constant", icon = "" },
                Constructor = { hl = "@constructor", icon = "" },
                Enum = { hl = "@type", icon = "" },
                EnumMember = { hl = "@field", icon = "" },
                Event = { hl = "@type", icon = "" },
                Field = { hl = "@field", icon = "" },
                File = { hl = "@text.uri", icon = "" },
                Fragment = { hl = "@constant", icon = "" },
                Function = { hl = "@function", icon = "" },
                Interface = { hl = "@type", icon = "" },
                Key = { hl = "@type", icon = "" },
                Method = { hl = "@method", icon = "ƒ" },
                Module = { hl = "@namespace", icon = "" },
                Namespace = { hl = "@namespace", icon = "" },
                Null = { hl = "@type", icon = "" },
                Number = { hl = "@number", icon = "#" },
                Object = { hl = "@type", icon = "" },
                Operator = { hl = "@operator", icon = "" },
                Package = { hl = "@namespace", icon = "" },
                Property = { hl = "@method", icon = "" },
                String = { hl = "@string", icon = "" },
                Struct = { hl = "@type", icon = "" },
                TypeParameter = { hl = "@parameter", icon = "" },
                Variable = { hl = "@constant", icon = "" },
            },
        },
    }
    outline.setup(opts)
end

return M
