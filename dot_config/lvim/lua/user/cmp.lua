local M = {}
M.kind = {
    Class = "󰌗 ",
    Color = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Default = " ",
    Enum = "󰕘",
    EnumMember = " ",
    Event = " ",
    Field = " ", -- "󰜢"
    File = "󰈙 ",
    Folder = " ",
    Function = " ",
    Interface = " ",
    Keyword = "󰌋 ",
    Method = "󰆧 ",
    Module = "󰏓 ",
    Operator = "󰆕 ",
    Property = " ",
    Reference = "󰈇 ",
    Snippet = " ", -- ""," "," "
    Struct = "󰕮",
    Text = "󰉿 ",
    TypeParameter = " ",
    Unit = "󰑭",
    Value = "󰎠 ",
    Variable = " ",
    Copilot = " ",
}

M.config = function()
    local cmp = require("cmp")
    lvim.builtin.cmp.sorting = {
        priority_weight = 2,
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    }
    lvim.builtin.cmp.sources = {
        { name = "copilot", group_index = 1 },
        { name = "luasnip", group_index = 1, max_item_count = 5, keyword_length = 3 },
        { name = "nvim_lsp", group_index = 1 },
        { name = "nvim_lsp_signature_help", group_index = 1 },
        { name = "nvim_lua", group_index = 1 },
        { name = "buffer", group_index = 1, max_item_count = 5, keyword_length = 3 },
        { name = "path", group_index = 1 },
        { name = "dictionary", group_index = 1, keyword_length = 2 },
        { name = "git", group_index = 1 },
        { name = "latex_symbols", group_index = 1 },
        { name = "cmp_zotcite", group_index = 1 },
        { name = "crates", group_index = 1 },
        { name = "emoji", group_index = 1 },
        { name = "otter", group_index = 1 },
        -- { name = "omni", group_index = 1 },
        { name = "vimtex", group_index = 1 },
    }

    lvim.builtin.cmp.experimental = {
        ghost_text = false,
        native_menu = false,
        custom_menu = true,
    }

    local cmp_border = {
        { "╭", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╮", "CmpBorder" },
        { "│", "CmpBorder" },
        { "╯", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╰", "CmpBorder" },
        { "│", "CmpBorder" },
    }

    local cmp_sources = {
        buffer = "(Buffer)",
        crates = "(Crates)",
        latex_symbols = "(LaTeX)",
        vimtex = "(Vimtex)",
        nvim_lua = "(NvLua)",
        copilot = "(Copilot)",
        dictionary = "(Dict)",
    }

    if lvim.builtin.borderless_cmp then
        vim.opt.pumblend = 4
        lvim.builtin.cmp.formatting.fields = { "abbr", "kind", "menu" }
        lvim.builtin.cmp.window = {
            completion = {
                border = cmp_border,
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            },
            documentation = {
                border = cmp_border,
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            },
        }

        lvim.builtin.cmp.formatting.format = function(entry, vim_item)
            if entry.source.name == "cmdline" then
                vim_item.kind = "⌘"
                vim_item.menu = ""
                return vim_item
            end
            vim_item.kind =
                string.format("%s %s", M.kind[vim_item.kind] or " ", cmp_sources[entry.source.name] or vim_item.kind)

            return vim_item
        end
    else
        lvim.builtin.cmp.formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                if entry.source.name == "cmdline" then
                    vim_item.kind = "⌘"
                    vim_item.menu = ""
                    return vim_item
                end
                vim_item.menu = cmp_sources[entry.source.name] or vim_item.kind
                vim_item.kind = M.kind[vim_item.kind] or vim_item.kind

                return vim_item
            end,
        }
    end

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
            ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        }),
        sources = {
            { name = "cmdline" },
            { name = "path" },
        },
        window = {
            completion = {
                border = cmp_border,
                winhighlight = "Search:None",
            },
        },
    })

    for _, cmd_type in ipairs({ "/", "?" }) do
        cmp.setup.cmdline(cmd_type, {
            mapping = cmp.mapping.preset.cmdline({}),
            sources = {
                { name = "buffer" },
                { name = "path" },
            },
            window = {
                completion = {
                    border = cmp_border,
                    winhighlight = "Search:None",
                },
            },
        })
    end

    cmp.setup.filetype("toml", {
        sources = cmp.config.sources({
            { name = "nvim_lsp", group_index = 1 },
            { name = "path", group_index = 1, max_item_count = 5 },
            { name = "buffer", group_index = 1 },
            { name = "crates", group_index = 1 },
            { name = "luasnip", group_index = 1, max_item_count = 5, keyword_length = 3 },
        }, {}),
    })

    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "nvim_lsp", group_index = 1 },
            { name = "git", group_index = 1 },
            { name = "path", group_index = 1 },
            { name = "buffer", group_index = 1 },
            { name = "dictionary", group_index = 1 },
            { name = "luasnip", group_index = 1, max_item_count = 5, keyword_length = 3 },
            { name = "emoji", group_index = 2 },
        }),
    })

    cmp.setup.filetype("markdown", {
        sources = cmp.config.sources({
            { name = "nvim_lsp", group_index = 1 },
            { name = "luasnip", group_index = 1, max_item_count = 5, keyword_length = 3 },
            { name = "otter", group_index = 1 },
            { name = "path", group_index = 1 },
            { name = "dictionary", group_index = 1 },
            { name = "buffer", group_index = 1 },
            { name = "emoji", group_index = 2 },
        }),
    })

    cmp.setup.filetype("tex", {
        sources = cmp.config.sources({
            { name = "latex_symbols", max_item_count = 3, keyword_length = 3 },
            { name = "vimtex", max_item_count = 3, keyword_length = 3 },
            { name = "nvim_lsp", max_item_count = 8 },
            { name = "cmp_zotcite", max_item_count = 3 },
            { name = "luasnip", max_item_count = 5 },
            { name = "buffer", max_item_count = 5, keyword_length = 5 },
            { name = "copilot", max_item_count = 3 },
            { name = "dictionary", group_index = 1, keyword_length = 2 },
            { name = "emoji", group_index = 2 },
        }),
    })
end

return M
