local M = {}

M.gruvbox = function()
    require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        invert_selection = true,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = true,
        transparent_mode = lvim.transparent_window,
    })
end

M.nightfox = function()
    require("nightfox").setup({
        options = {
            -- Compiled file's destination location
            compile_path = vim.fn.stdpath("cache") .. "/nightfox",
            compile_file_suffix = "_compiled", -- Compiled file suffix
            transparent = lvim.transparent_window, -- Disable setting background
            terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
            dim_inactive = true, -- Non focused panes set to alternative background
            module_default = true, -- Default enable value for modules
            styles = { -- Style to be applied to different syntax groups
                comments = "italic", -- Value is any valid attr-list value `:help attr-list`
                conditionals = "NONE",
                constants = "NONE",
                functions = "NONE",
                keywords = "italic",
                types = "italic,bold",
                numbers = "NONE",
                operators = "NONE",
                strings = "NONE",
                variables = "NONE",
            },
            inverse = { -- Inverse highlight for different types
                match_paren = true,
                visual = true,
                search = true,
            },
        },
    })
end

M.tokyonight = function()
    lvim.builtin.theme.tokyonight.options = {
        style = "moon",
        transparent = lvim.transparent_window,
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
            sidebars = "dark",
            floats = "dark",
        },
        sidebars = {
            "qf",
            "vista_kind",
            "terminal",
            "lazy",
            "spectre_panel",
            "NeogitStatus",
            "help",
        },
        day_brightness = 0.3,
        hide_inactive_statusline = true,
        dim_inactive = true,
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

        on_colors = function(colors)
            colors.git = { change = "#6183bb", add = "#449dab", delete = "#f7768e", conflict = "#bb7a61" }
            colors.bg_dark = "#1a1e30"
            colors.bg_dim = "#1f2335"
            colors.bg_float = "#1a1e30"
        end,
        on_highlights = function(hl, c)
            c.bg_dark = "#1a1e30"
            c.bg_dim = "#1f2335"
            c.bg_float = "#1a1e30"
            local current_colors = M.colors.tokyonight_colors
            hl.NormalFloat = { fg = current_colors.fg, bg = "#181924" }
            hl.Cursor = { fg = current_colors.bg, bg = current_colors.fg }
            hl.NormalNC = { fg = current_colors.fg_dark, bg = "#1c1d28" }
            hl.Normal = { fg = current_colors.fg, bg = "#1f2335" }
            hl.CursorLineNr = { fg = current_colors.orange }
            hl["rainbow1"] = { fg = c.red, bg = "#24283b" }
            hl["rainbow2"] = { fg = c.orange, bg = "#24283b" }
            hl["rainbow3"] = { fg = c.yellow, bg = "#24283b" }
            hl["rainbow4"] = { fg = c.green, bg = "#24283b" }
            hl["rainbow5"] = { fg = c.teal, bg = "#24283b" }
            hl["rainbow6"] = { fg = c.magenta, bg = "#24283b" }
        end,
        cache = true,
    }
end

M.rose_pine = function()
    require("rose-pine").setup({
        ---@usage 'main'|'moon'
        variant = "main",
        dark_variant = "main",
        dim_inactive_windows = lvim.builtin.global_statusline,
        extend_background_behind_borders = true,
        styles = {
            bold = true,
            italic = true,
            transparency = lvim.transparent_window,
        },
        groups = {
            border = "highlight_med",
            comment = "muted",
            link = "iris",
            punctuation = "subtle",

            error = "love",
            hint = "iris",
            info = "foam",
            warn = "gold",

            headings = {
                h1 = "iris",
                h2 = "foam",
                h3 = "rose",
                h4 = "gold",
                h5 = "pine",
                h6 = "foam",
            },
        },

        highlight_groups = {
            Boolean = { fg = "love" },
            Cursor = { fg = "#232136", bg = "text" },
            NormalFloat = { bg = "base" },
            MsgArea = { fg = "text" },
            VertSplit = { fg = "highlight_low", bg = "highlight_low" },
            SignColumn = { fg = "text", bg = "none" },
            SignColumnSB = { fg = "text", bg = "none" },
            mkdInlineURL = { fg = "iris" },
            ["@variable"] = { fg = "text" },
            ["@variable.builtin"] = { fg = "love" },
            ["@type"] = { fg = "foam" },
            ["@text"] = { fg = "text" },
            ["@property"] = { fg = "iris" },
            ["@parameter"] = { fg = "iris", italic = true },
            ["@constant.builtin"] = { fg = "love" },
            ["@constant"] = { fg = "foam" },
            ["@constructor"] = { fg = "foam" },
            ["@field"] = { fg = "foam" },
            ["@function.builtin"] = { fg = "love" },
            ["@function"] = { fg = "rose" },
            ["@include"] = { fg = "pine" },
            ["@keyword"] = { fg = "pine", italic = true, bold = true },
            ["@keyword.operator"] = { fg = "subtle" },
            ["@label"] = { fg = "foam" },
            ["@punctuation.bracket"] = { fg = "muted" },
            ["@punctuation.delimiter"] = { fg = "muted" },
            ["@punctuation.special"] = { fg = "muted" },
            ["@string.escape"] = { fg = "pine" },
            ["@string.special"] = { fg = "gold" },
            ["@tag"] = { fg = "foam" },
            ["@tag.delimiter"] = { fg = "subtle" },
            ["@text.title"] = { fg = "iris" },
            ["@text.uri"] = { fg = "iris" },
            CmpItemKindText = { fg = "gold" },
            CmpItemKindConstructor = { fg = "foam" },
            CmpItemKindField = { fg = "foam" },
            CmpItemKindValue = { fg = "text" },
            CmpItemKindEvent = { fg = "text" },
            CmpItemKindUnit = { fg = "gold" },
            CmpItemKindConstant = { fg = "gold" },
            CmpItemKindModule = { fg = "iris" },
            CmpItemKindEnum = { fg = "#c5a8e8" },
            CmpItemKindStruct = { fg = "#56949f" },
            CmpItemKindTypeParameter = { fg = "foam" },
            CmpItemKindTypeKeyword = { fg = "pine" },
            CmpItemKindTypeDirectory = { fg = "foam" },
            CmpItemKindReference = { fg = "gold" },
            CmpItemKindOperator = { fg = "subtle" },
            CmpItemKindTypeSnippet = { fg = "pine" },
            ColorColumn = { bg = "#16141f" },
            rainbow1 = { fg = "#eb6f92", bg = "#2a273f" },
            rainbow2 = { fg = "#ea9d34", bg = "#2a273f" },
            rainbow3 = { fg = "#f7c177", bg = "#2a273f" },
            rainbow4 = { fg = "#31748f", bg = "#2a273f" },
            rainbow5 = { fg = "#9ccfd8", bg = "#2a273f" },
            rainbow6 = { fg = "#c4a7e7", bg = "#2a273f" },
        },
    })
end

M.catppuccin = function()
    local catppuccin = require("catppuccin")
    local opts = {
        flavour = "mocha",
        background = { light = "latte", dark = "mocha" },
        transparent_background = lvim.transparent_window,
        term_colors = true,
        styles = {
            comments = { "italic" }, -- Value is any valid attr-list value `:help attr-list`
            keywords = { "italic" },
            types = { "italic,bold" },
        },

        compile = {
            enabled = true, -- NOTE: make sure to run `:CatppuccinCompile`
            path = vim.fn.stdpath("cache") .. "/catppuccin",
        },
        dim_inactive = {
            enabled = lvim.builtin.global_statusline,
            shade = "dark",
            percentage = 0.15,
        },
        integrations = {
            cmp = true,
            fidget = true,
            lsp_trouble = true,
            telescope = true,
            treesitter = true,
            mason = true,
            neotest = lvim.builtin.test_runner == "neotest",
            noice = lvim.builtin.noice.active,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = {},
                    warnings = { "italic" },
                    information = {},
                },
                underlines = {
                    errors = { "undercurl" },
                    hints = {},
                    warnings = { "undercurl" },
                    information = {},
                },
            },
            dap = {
                enabled = lvim.builtin.dap.active,
                enable_ui = lvim.builtin.dap.active,
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            gitsigns = lvim.builtin.gitsigns.active,
            notify = lvim.builtin.noice.active,
            nvimtree = true,
            neotree = lvim.builtin.tree_provider == "neo-tree",
            overseer = lvim.builtin.task_runner == "overseer",
            symbols_outline = lvim.builtin.tag_provider == "symbols-outline",
            which_key = lvim.builtin.which_key.active,
            leap = lvim.builtin.motion_provider == "leap",
            hop = lvim.builtin.motion_provider == "hop",
        },

        color_overrides = {},
        highlight_overrides = {
            mocha = {
                NormalFloat = { fg = "#CDD6F4", bg = "#151521" },
                CmpItemKindEnum = { fg = "#B4BEFE" },
                CmpItemKindEnumMember = { fg = "#F5C2E7" },
                CmpItemMenu = { fg = "#7F849C" },
                CmpItemAbbr = { fg = "#BAC2DE" },
                ColorColumn = { bg = "#181825" },
                Cursor = { fg = "#1e1e2e", bg = "#d9e0ee" },
                ["@constant.builtin"] = { fg = "#EBA0AC" },
                TSConstBuiltin = { fg = "#EBA0AC" },
                rainbow1 = { fg = "#f38ba8", bg = "#302D41" },
                rainbow2 = { fg = "#fab387", bg = "#302D41" },
                rainbow3 = { fg = "#f9e2af", bg = "#302D41" },
                rainbow4 = { fg = "#a6e3a1", bg = "#302D41" },
                rainbow5 = { fg = "#74c7ec", bg = "#302D41" },
                rainbow6 = { fg = "#b4befe", bg = "#302D41" },
            },
        },
    }

    if lvim.transparent_window then
        local colors = require("catppuccin.palettes").get_palette()
        colors.none = "NONE"
        opts.custom_highlights = {
            Comment = { fg = colors.overlay1 },
            LineNr = { fg = colors.overlay1 },
            CursorLine = { bg = colors.none },
            CursorLineNr = { fg = colors.lavender },
            DiagnosticVirtualTextError = { bg = colors.none },
            DiagnosticVirtualTextWarn = { bg = colors.none },
            DiagnosticVirtualTextInfo = { bg = colors.none },
            DiagnosticVirtualTextHint = { bg = colors.none },
        }
    end
    catppuccin.setup(opts)
end

M.kanagawa = function()
    local kanagawa = require("kanagawa")
    kanagawa.setup({
        undercurl = true, -- enable undercurls
        commentStyle = {},
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { italic = true },
        typeStyle = {},
        variablebuiltinStyle = { italic = true },
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        dimInactive = lvim.builtin.global_statusline, -- dim inactive window `:h hl-NormalNC`
        globalStatus = lvim.builtin.global_statusline, -- adjust window separators highlight for laststatus=3
        transparent = lvim.transparent_window,
        colors = {
            palette = { sumiInk1b = "#1b1b23" },
            theme = {
                all = {
                    ui = {
                        bg_gutter = "none",
                    },
                },
            },
        },
        overrides = function(_)
            return {
                diffRemoved = { fg = "#E46876" },
                NvimTreeFolderIcon = { fg = "#7e9cd8" },
                CmpItemKindEnum = { fg = "#957FB8" },
                ["@parameter"] = { fg = "#DCA561" },
                rainbow1 = { fg = "#C34043", bg = "#21212A" },
                rainbow2 = { fg = "#FFA066", bg = "#21212A" },
                rainbow3 = { fg = "#DCA561", bg = "#21212A" },
                rainbow4 = { fg = "#76946A", bg = "#21212A" },
                rainbow5 = { fg = "#4e8ca2", bg = "#21212A" },
                rainbow6 = { fg = "#949fb5", bg = "#21212A" },
                ColorColumn = { bg = "#181820" },
            }
        end,
        theme = "wave",
        background = {
            dark = "wave",
            light = "lotus",
        },
    })
end

M.colors = {
    tokyonight_colors = {
        cmp_border = "#181924",
        none = "NONE",
        bg_dark = "#1f2335",
        bg_alt = "#1a1b26",
        bg = "#24283b",
        bg_br = "#292e42",
        terminal_black = "#414868",
        fg = "#c0caf5",
        fg_dark = "#a9b1d6",
        fg_gutter = "#3b4261",
        dark3 = "#545c7e",
        comment = "#565f89",
        dark5 = "#737aa2",
        blue0 = "#3d59a1",
        blue = "#7aa2f7",
        cyan = "#7dcfff",
        blue1 = "#2ac3de",
        blue2 = "#0db9d7",
        blue5 = "#89ddff",
        blue6 = "#B4F9F8",
        blue7 = "#394b70",
        violet = "#bb9af7",
        magenta = "#bb9af7",
        magenta2 = "#ff007c",
        purple = "#9d7cd8",
        orange = "#ff9e64",
        yellow = "#e0af68",
        hlargs = "#e0af68",
        green = "#9ece6a",
        green1 = "#73daca",
        green2 = "#41a6b5",
        teal = "#1abc9c",
        red = "#f7768e",
        red1 = "#db4b4b",
        git = { change = "#6183bb", add = "#449dab", delete = "#f7768e", conflict = "#bb7a61" },
        gitSigns = { add = "#164846", change = "#394b70", delete = "#823c41" },
    },

    gruvbox_colors = {
        cmp_border = "#282828",
        none = "NONE",
        bg = "#282828",
        bg_alt = "#3c3836",
        bg_dark = "#1d2021",
        bg_br = "#32302f",
        fg = "#ebdbb2",
        fg_dark = "#a89984",
        fg_gutter = "#3b4261",
        dark3 = "#928374",
        comment = "#928374",
        dark5 = "#928374",
        blue0 = "#458588",
        blue = "#83a598",
        cyan = "#8ec07c",
        blue1 = "#689d6a",
        blue2 = "#98971a",
        blue5 = "#b8bb26",
        blue6 = "#fabd2f",
        blue7 = "#d79921",
        violet = "#d3869b",
        magenta = "#d3869b",
        magenta2 = "#fb4934",
        purple = "#b16286",
        orange = "#fe8019",
        yellow = "#fabd2f",
        hlargs = "#fabd2f",
        green = "#b8bb26",
        green1 = "#98971a",
        green2 = "#689d6a",
        teal = "#689d6a",
        red = "#cc241d",
        red1 = "#fb4934",
        git = { change = "#458588", add = "#98971a", delete = "#cc241d", conflict = "#d79921" },
        gitSigns = { add = "#98971a", change = "#458588", delete = "#cc241d" },
    },

    rose_pine_colors = {
        cmp_border = "#191724",
        none = "NONE",
        bg = "#2a273f",
        fg = "#e0def4",
        fg_gutter = "#3b4261",
        black = "#393b44",
        gray = "#2a2e36",
        red = "#eb6f92",
        green = "#97c374",
        yellow = "#ea9d34",
        hlargs = "#c4a7e7",
        blue = "#9ccfd8",
        magenta = "#c4a7e7",
        cyan = "#9ccfd8",
        white = "#dfdfe0",
        orange = "#ea9a97",
        pink = "#D67AD2",
        black_br = "#7f8c98",
        red_br = "#e06c75",
        green_br = "#58cd8b",
        yellow_br = "#FFE37E",
        bg_br = "#393552",
        blue_br = "#84CEE4",
        violet = "#B8A1E3",
        cyan_br = "#59F0FF",
        white_br = "#FDEBC3",
        orange_br = "#F6A878",
        pink_br = "#DF97DB",
        comment = "#526175",
        bg_alt = "#191724",
        git = {
            add = "#84Cee4",
            change = "#c4a7e7",
            delete = "#eb6f92",
            conflict = "#f6c177",
        },
    },

    catppuccin_colors = {
        cmp_border = "#151521",
        rosewater = "#F5E0DC",
        flamingo = "#F2CDCD",
        violet = "#DDB6F2",
        pink = "#F5C2E7",
        red = "#F28FAD",
        maroon = "#E8A2AF",
        orange = "#FAB387",
        yellow = "#F9E2AF",
        hlargs = "#EBA0AC",
        green = "#ABE9B3",
        blue = "#96CDFB",
        cyan = "#89DCEB",
        teal = "#B5E8E0",
        lavender = "#C9CBFF",
        white = "#D9E0EE",
        gray2 = "#C3BAC6",
        gray1 = "#988BA2",
        gray0 = "#6E6C7E",
        black4 = "#575268",
        bg_br = "#302D41",
        bg = "#302D41",
        surface1 = "#302D41",
        bg_alt = "#1E1E2E",
        fg = "#D9E0EE",
        fg_dark = "#D9E0EE",
        black = "#1A1826",
        git = {
            add = "#ABE9B3",
            change = "#96CDFB",
            delete = "#F28FAD",
            conflict = "#FAE3B0",
        },
    },

    kanagawa_colors = {
        cmp_border = "#16161D",
        bg = "#21212A",
        bg_alt = "#1F1F28",
        bg_br = "#363646",
        fg = "#DCD7BA",
        fg_dark = "#DCD7BA",
        red = "#E46876",
        orange = "#FFA066",
        yellow = "#DCA561",
        hlargs = "#DCA561",
        blue = "#7FB4CA",
        cyan = "#658594",
        violet = "#957FB8",
        magenta = "#938AA9",
        green = "#76946A",
        git = {
            add = "#76946A",
            conflict = "#DCA561",
            delete = "#E46876",
            change = "#7FB4CA",
        },
    },
}

M.current_colors = function()
    if lvim.colorscheme == "tokyonight" then
        return M.colors.tokyonight_colors
    elseif lvim.colorscheme == "catppuccin" then
        return M.colors.catppuccin_colors
    elseif lvim.colorscheme == "kanagawa" then
        return M.colors.kanagawa_colors
    elseif lvim.colorscheme == "rose-pine" then
        return M.colors.rose_pine_colors
    elseif lvim.colorscheme == "nightfox" then
        return M.colors.tokyonight_colors
    elseif lvim.colorscheme == "gruvbox" then
        return M.colors.gruvbox_colors
    else
        return M.colors.tokyonight_colors
    end
end

M.hi_colors = function()
    local colors = {
        bg = "#16161D",
        bg_alt = "#404040",
        fg = "#DCD7BA",
        green = "#76946A",
        red = "#E46876",
        blue = "#7aa0f7",
    }
    local color_binds = {
        bg = { group = "NormalFloat", property = "background" },
        bg_alt = { group = "Cursor", property = "foreground" },
        fg = { group = "Cursor", property = "background" },
        green = { group = "diffAdded", property = "foreground" },
        red = { group = "diffRemoved", property = "foreground" },
    }
    local function get_hl_by_name(name)
        local ret = vim.api.nvim_get_hl(0, { name = name.group })
        return string.format("#%06x", ret[name.property])
    end

    for k, v in pairs(color_binds) do
        local found, color = pcall(get_hl_by_name, v)
        if found then
            colors[k] = color
        end
    end
    return colors
end

M.telescope_theme = function(colorset)
    local function link(group, other)
        vim.cmd("highlight! link " .. group .. " " .. other)
    end

    local function set_bg(group, bg)
        vim.cmd("hi " .. group .. " guibg=" .. bg)
    end

    local function set_fg_bg(group, fg, bg)
        vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg)
    end

    set_fg_bg("SpecialComment", "#9ca0a4", "bold")
    link("FocusedSymbol", "LspHighlight")
    link("LspCodeLens", "SpecialComment")
    link("LspDiagnosticsSignError", "DiagnosticError")
    link("LspDiagnosticsSignHint", "DiagnosticHint")
    link("LspDiagnosticsSignInfo", "DiagnosticInfo")
    link("NeoTreeDirectoryIcon", "NvimTreeFolderIcon")
    link("IndentBlanklineIndent1 ", "@comment")

    if lvim.builtin.time_based_themes then
        local current_colors = colorset
        if colorset == nil or #colorset == 0 then
            current_colors = M.current_colors()
        end
        set_fg_bg("Hlargs", current_colors.hlargs, "none")
        set_fg_bg("CmpBorder", current_colors.cmp_border, current_colors.cmp_border)
        link("NoiceCmdlinePopupBorder", "CmpBorder")
        link("NoiceCmdlinePopupBorderCmdline", "CmpBorder")
        link("NoiceCmdlinePopupBorderFilter", "CmpBorder")
        link("NoiceCmdlinePopupBorderHelp", "CmpBorder")
        link("NoiceCmdlinePopupBorderIncRename", "CmpBorder")
        link("NoiceCmdlinePopupBorderInput", "CmpBorder")
        link("NoiceCmdlinePopupBorderLua", "CmpBorder")
        link("NoiceCmdlinePopupBorderSearch", "CmpBorder")
        set_fg_bg("diffAdded", current_colors.git.add, "NONE")
        set_fg_bg("diffRemoved", current_colors.git.delete, "NONE")
        set_fg_bg("diffChanged", current_colors.git.change, "NONE")
        set_fg_bg("WinSeparator", current_colors.bg_alt, current_colors.bg_alt)
        set_fg_bg("SignColumn", current_colors.bg, "NONE")
        set_fg_bg("SignColumnSB", current_colors.bg, "NONE")

        link("@markup.heading.1.markdown", "rainbow1")
        link("@markup.heading.2.markdown", "rainbow2")
        link("@markup.heading.3.markdown", "rainbow3")
        link("@markup.heading.4.markdown", "rainbow4")
        link("@markup.heading.5.markdown", "rainbow5")
        link("@markup.heading.6.markdown", "rainbow6")
    end

    local hi_colors = M.hi_colors()
    set_fg_bg("NormalFloat", hi_colors.fg, hi_colors.bg)
    set_fg_bg("FloatBorder", hi_colors.fg, hi_colors.bg)

    if lvim.builtin.telescope.active then
        set_fg_bg("TelescopeBorder", hi_colors.bg_alt, hi_colors.bg)
        set_fg_bg("TelescopePromptBorder", hi_colors.bg, hi_colors.bg)
        set_fg_bg("TelescopePromptNormal", hi_colors.fg, hi_colors.bg_alt)
        set_fg_bg("TelescopePromptPrefix", hi_colors.red, hi_colors.bg)
        set_bg("TelescopeNormal", hi_colors.bg)
        set_fg_bg("TelescopePreviewTitle", hi_colors.bg, hi_colors.green)
        set_fg_bg("LvimInfoHeader", hi_colors.bg, hi_colors.green)
        set_fg_bg("LvimInfoIdentifier", hi_colors.red, hi_colors.bg_alt)
        set_fg_bg("TelescopePromptTitle", hi_colors.bg, hi_colors.red)
        set_fg_bg("TelescopeResultsTitle", hi_colors.bg, hi_colors.bg)
        set_fg_bg("TelescopeResultsBorder", hi_colors.bg, hi_colors.bg)
        set_bg("TelescopeSelection", hi_colors.bg_alt)
    else
        set_fg_bg("FzfLuaBorder", hi_colors.bg, hi_colors.bg)
        set_bg("FzfLuaNormal", hi_colors.bg)
        set_fg_bg("FzfLuaTitle", hi_colors.bg, hi_colors.red)
        set_fg_bg("FzfLuaPreviewTitle", hi_colors.bg, hi_colors.green)
        set_fg_bg("FzfLuaPreviewBorder", hi_colors.bg, hi_colors.bg)
        set_fg_bg("FzfLuaScrollBorderEmpty", hi_colors.bg, hi_colors.bg)
        set_fg_bg("FzfLuaScrollBorderFull", hi_colors.bg, hi_colors.bg)
        set_fg_bg("FzfLuaHelpNormal", hi_colors.bg_alt, hi_colors.bg)
    end

    local bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg
    local hl = vim.api.nvim_get_hl(0, { name = "Folded" })
    hl.bg = bg
    vim.api.nvim_set_hl(0, "Folded", { fg = hl.fg, bg = hl.bg })
    vim.opt.foldtext = [[luaeval('HighlightedFoldtext')()]]

    if lvim.builtin.symbol_usage.active then
        local function h(name)
            return vim.api.nvim_get_hl(0, { name = name })
        end

        vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
        vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
        vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
        vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
        vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })
    end
    -- for markdown preview
    link("MarkviewHeading1", "rainbow1")
    link("MarkviewHeading1Sign", "rainbow1")
    link("MarkviewHeading2", "rainbow2")
    link("MarkviewHeading2Sign", "rainbow2")
    link("MarkviewHeading3", "rainbow3")
    link("MarkviewHeading4", "rainbow4")
    link("MarkviewHeading5", "rainbow5")
    link("MarkviewHeading6", "rainbow6")
end

M.dashboard_theme = function()
    -- Dashboard header colors
    vim.api.nvim_set_hl(0, "StartLogo1", { fg = "#1C506B" })
    vim.api.nvim_set_hl(0, "StartLogo2", { fg = "#1D5D68" })
    vim.api.nvim_set_hl(0, "StartLogo3", { fg = "#1E6965" })
    vim.api.nvim_set_hl(0, "StartLogo4", { fg = "#1F7562" })
    vim.api.nvim_set_hl(0, "StartLogo5", { fg = "#21825F" })
    vim.api.nvim_set_hl(0, "StartLogo6", { fg = "#228E5C" })
    vim.api.nvim_set_hl(0, "StartLogo7", { fg = "#239B59" })
    vim.api.nvim_set_hl(0, "StartLogo8", { fg = "#24A755" })
end

M.toggle_theme = function()
    local theme = lvim.colorscheme
    local colorset = require("user.theme").colors.tokyonight_colors
    if theme == "tokyonight" then
        lvim.colorscheme = "nightfox"
        colorset = require("user.theme").colors.tokyonight_colors
    elseif theme == "nightfox" then
        lvim.colorscheme = "kanagawa"
        colorset = require("user.theme").colors.kanagawa_colors
    elseif theme == "gruvbox" then
        lvim.colorscheme = "gruvbox"
        colorset = require("user.theme").colors.gruvbox_colors
    elseif theme == "catppuccin" then
        lvim.colorscheme = "catppuccin"
        colorset = require("user.theme").colors.catppuccin_colors
    else
        lvim.colorscheme = "tokyonight"
    end
    vim.cmd("colorscheme " .. lvim.colorscheme)
    require("user.theme").telescope_theme(colorset)
end

return M
