lvim.plugins = {

    -------------------------
    --        theme        --
    -------------------------
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("user.theme").kanagawa()
        end,
        enabled = lvim.builtin.theme.name == "kanagawa",
    },

    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("user.theme").nightfox()
        end,
        enabled = lvim.builtin.theme.name == "nightfox",
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("user.theme").rose_pine()
        end,
        enabled = lvim.builtin.theme.name == "rose-pine",
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("user.theme").catppuccin()
        end,
        enabled = lvim.builtin.theme.name == "catppuccin",
    },

    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({
                undercurl = true,
                underline = true,
                bold = true,
                italic = true,
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },

    -----------------------------
    --        operation        --
    -----------------------------
    { "machakann/vim-sandwich" },

    -- -----------------------
    -- --        lsp        --
    -- -----------------------

    -- cpp
    { "p00f/clangd_extensions.nvim" },
    { "Civitasv/cmake-tools.nvim" },

    -- rust
    { "rust-lang/rust.vim" },
    { "simrat39/rust-tools.nvim" },
    {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup({
                null_ls = {
                    enabled = true,
                    name = "crates",
                },
            })
        end,
    },

    -- better quick fix
    {
        "kevinhwang91/nvim-bqf",
        event = { "BufRead", "BufNew" },
        config = function()
            require("user.bqf").config()
        end,
    },

    -- todo comments
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },

    -- show line number
    {
        "nacro90/numb.nvim",
        config = function()
            require("user.numb").config()
        end,
    },

    -- show symbols-outline
    {
        "simrat39/symbols-outline.nvim",
        config = require("user.symbols-outline").config(),
    },

    -- show lsp progress
    {
        "j-hui/fidget.nvim",
        config = function()
            require("user.fidget").config()
        end,
    },

    -- show lsp inlay hints
    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("user.inlay-hints").config()
        end,
    },

    -- show lsp signature
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require("user.lsp_signature").config()
        end,
    },

    -- use copilot
    {
        "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup({
                    plugin_manager_path = get_runtime_dir() .. "/site/pack/lazy",
                    suggestion = {
                        enabled = false,
                        auto_trigger = true,
                        debounce = 75,
                        keymap = {
                            accept = "<M-m>",
                            next = "<M-]>",
                            prev = "<M-[>",
                            dismiss = "<C-]>",
                        },
                        panel = { enabled = false },
                    },
                })
            end, 100)
        end,
    },

    -- add copilot to cmp source
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "copilot.lua", "nvim-cmp" },
        config = function()
            require("copilot_cmp").setup({
                method = "getCompletionsCycling",
                formatters = {
                    label = require("copilot_cmp.format").format_label_text,
                    insert_text = require("copilot_cmp.format").format_insert_text,
                    preview = require("copilot_cmp.format").deindent,
                },
            })
        end,
    },

    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                width = 120, -- Width of the floating window
                height = 25, -- Height of the floating window
                default_mappings = true, -- Bind default mappings
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                -- You can use "default_mappings = true" setup option
                -- Or explicitly set keybindings
                --
                -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
                -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
                -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
            })
        end,
    },

    -- latex and markdown
    -- https://github.com/iamcco/markdown-preview.nvim/tree/
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = "markdown",
        config = function()
            vim.g.mkdp_auto_start = 0
        end,
    },

    -- Glow markdown preview
    {
        "ellisonleao/glow.nvim",
        config = function()
            require("glow").setup({})
        end,
        ft = { "markdown" },
    },

    { "barreiroleo/ltex-extra.nvim" },

    {
        "AckslD/nvim-FeMaco.lua",
        config = function()
            require("femaco").setup()
        end,
    },

    -- show math equation
    { "jbyuki/nabla.nvim" },

    {
        "SidOfc/mkdx",
        config = function()
            require("user.mkdx").config()
        end,
    },

    {
        "lervag/vimtex",
        config = function()
            require("user.vimtex").config()
        end,
        lazy = false,
    },

    { "ThePrimeagen/vim-be-good", lazy = true },

    -- -- note
    -- -- https://github.com/renerocksai/telekasten.nvim

    -- -- r
    -- -- { "jalvesaq/Nvim-R" },

    -- translator
    -- https://github.com/voldikss/vim-translator#know-bugs
    {
        "voldikss/vim-translator",
        config = function()
            require("user.vim-translator").vim_translator()
        end,
    },

    -- Cmp for command line
    { "hrsh7th/cmp-cmdline" },
    { "dmitmel/cmp-cmdline-history" },
    -- Cmp for emojis..
    { "hrsh7th/cmp-emoji" },
    -- Cmp for to calculate maths expressions.
    { "hrsh7th/cmp-calc" },
    -- cmp_dictionay
    -- https://github.com/uga-rosa/cmp-dictionary/wiki/Examples-of-usage
    {
        "uga-rosa/cmp-dictionary",
        config = function()
            require("cmp_dictionary").setup({
                dic = {
                    ["tex"] = "~/.config/dict/en.dict",
                    ["markdown"] = "~/.config/dict/en.dict",
                    ["rst"] = "~/.config/dict/en.dict",
                    ["*"] = {},
                },
            })
        end,
    },
    -- Cmp for github/gitlab issues
    {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("cmp_git").setup()
        end,
    },
    -- cmp for lsp signature help
    { "hrsh7th/cmp-nvim-lsp-signature-help" },

    -- -----------------------------------
    -- --        session manager        --
    -- -----------------------------------

    {
        "olimorris/persisted.nvim",
        -- lazy = true,
        config = function()
            require("user.persisted").config()
        end,
        enabled = lvim.builtin.session_manager == "persisted",
    },

    {
        "jedrzejboczar/possession.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("user.possession").config()
        end,
        enabled = lvim.builtin.session_manager == "possession",
    },

    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("user.octo").config()
        end,
    },

    -- Refactoring
    {
        "ThePrimeagen/refactoring.nvim",
        ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "rust", "kotlin" },
        event = "BufReadPost",
        lazy = true,
        config = function()
            require("user.refactoring").config()
        end,
        enabled = lvim.builtin.refactoring,
    },

    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("user.lsplines").config()
        end,
    },

    {
        "stevearc/dressing.nvim",
        config = function()
            require("user.dressing").config()
        end,
        -- lazy = true,
    },

    -- -- neotest
    -- -- { "nvim-neotest/neotest-python", event = { "BufEnter *.py" } },
    -- -- { "rouge8/neotest-rust", event = { "BufEnter *.rs" } },
    -- -- {
    -- -- 	"nvim-neotest/neotest",
    -- -- 	config = require("user.neotest").post(),
    -- -- 	dependencies = { "nvim-neotest/neotest-plenary" },
    -- -- 	event = { "BufReadPost", "BufNew" },
    -- -- },
    -- -- { "nvim-neotest/neotest-go", event = { "BufEnter *.go" } },

    {
        "sudormrfbin/cheatsheet.nvim",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        lazy = true,
        enabled = lvim.builtin.cheatsheet.active,
    },

    --  https://github.com/cshuaimin/ssr.nvim/
    {
        "cshuaimin/ssr.nvim",
        -- Calling setup is optional.
        config = function()
            require("user.ssr").config()
        end,
        lazy = true,
        enabled = lvim.builtin.ssr.ctive,
    },

    -- ----------------------------
    -- --        zen mode        --
    -- ----------------------------

    {
        "folke/zen-mode.nvim",
        enabled = lvim.builtin.zen.active,
    },
    {
        "folke/twilight.nvim",
        enabled = lvim.builtin.twilight.active,
    },

    -- https://github.com/danymat/neogen/tree/
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("neogen").setup({
                snippet_engine = "luasnip",
            })
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
        lazy = true,
    },

    -- Clipboard management
    {
        "AckslD/nvim-neoclip.lua",
        config = require("user.neoclip").config(),
    },

    {
        "michaelb/sniprun",
        build = "bash ./install.sh",
        enabled = lvim.builtin.sniprun.active,
    },

    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup({
                easing_function = "quadratic",
                hide_cursor = true,
            })
        end,
        event = "BufRead",
        enabled = lvim.builtin.smooth_scroll == "neoscroll",
    },

    -- https://github.com/declancm/cinnamon.nvim
    {
        "declancm/cinnamon.nvim",
        config = function()
            require("cinnamon").setup({
                default_keymaps = true,
                default_delay = 4,
                extra_keymaps = true,
                extended_keymaps = false,
                centered = true,
                scroll_limit = 100,
            })
        end,
        event = "BufRead",
        enabled = lvim.builtin.smooth_scroll == "cinnamon",
    },

    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
        end,
        enabled = lvim.builtin.nvim_scrollbar.active,
    },

    -- ---------------------------------------
    -- --        telescope extension        --
    -- ---------------------------------------

    -- { "nanotee/zoxide.vim" },

    -- {
    -- 	"jvgrootveld/telescope-zoxide",
    -- 	dependencies = { "nvim-telescope/telescope.nvim" },
    -- 	lazy = true,
    -- },

    {
        "cljoly/telescope-repo.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = true,
    },

    -- Telescope file browser
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
    },

    -- -- Telescope live grep
    -- {
    --     "nvim-telescope/telescope-live-grep-args.nvim",
    --     lazy = true,
    -- },
    {
        "danielfalk/smart-open.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        lazy = true,
    },

    -------------------------
    --        noice        --
    -------------------------

    { "MunifTanjim/nui.nvim" },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("user.noice").config()
        end,
        -- version = '1.5.2',
        dependencies = {
            "rcarriga/nvim-notify",
            "MunifTanjim/nui.nvim",
        },
        enabled = lvim.builtin.noice.active,
    },

    --------------------------
    --        others        --
    --------------------------

    {
        "krivahtoo/silicon.nvim",
        build = "./install.sh build",
        config = function()
            require("user.silicon").config()
        end,
        event = "VeryLazy",
    },

    {
        "glacambre/firenvim",
        build = function()
            vim.fn["firenvim#install"](0)
        end,
    },

    ------------------------------
    --        Daily Life        --
    ------------------------------
    {
        "renerocksai/telekasten.nvim",
        config = function()
            require("user.telekasten").config()
        end,
        enabled = lvim.builtin.note == "telekasten",
        event = "VeryLazy",
    },

    {
        "phaazon/mind.nvim",
        branch = "v2.2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("user.mind").config()
        end,
        event = "VeryLazy",
        enabled = lvim.builtin.note == "mind",
    },

    -- Trouble
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                auto_open = false,
                auto_close = true,
                padding = false,
                height = 10,
                use_diagnostic_signs = true,
            })
        end,
        cmd = "Trouble",
        event = "VeryLazy",
        enabled = lvim.builtin.trouble.active,
    },

    {
        "krady21/compiler-explorer.nvim",
        config = function()
            require("compiler-explorer").setup({
                url = "https://godbolt.org",
                open_qflist = false, -- Open qflist after compile.
                infer_lang = true, -- Try to infer possible language based on file extension.
                binary_hl = "Comment", -- Highlight group for binary extmarks/virtual text.
                autocmd = {
                    enable = false, -- Enable assembly to source and source to assembly highlighting.
                    hl = "Cursorline", -- Highlight group used for line match highlighting.
                },
                diagnostics = { -- vim.diagnostic.config() options for the ce-diagnostics namespace.
                    underline = false,
                    virtual_text = false,
                    signs = false,
                },
                split = "split", -- How to split the window after the second compile (split/vsplit).
                spinner_frames = { "⣼", "⣹", "⢻", "⠿", "⡟", "⣏", "⣧", "⣶" }, -- Compiling... spinner settings.
                spinner_interval = 100,
                compiler_flags = "", -- Default flags passed to the compiler.
                job_timeout = 25000, -- Timeout for libuv job in milliseconds.
            })
        end,
        lazy = true,
    },

    -- view image in terminal
    {
        "princejoogie/chafa.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "m00qek/baleia.nvim",
        },
        config = function()
            require("chafa").setup({
                render = {
                    min_padding = 5,
                    show_label = true,
                },
                events = {
                    update_on_nvim_resize = true,
                },
            })
        end,
        lazy = true,
        enabled = lvim.builtin.image_viewer == "chafa",
    },

    --chatgpt
    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("ChatGPT").setup({})
        end,
        event = "VeryLazy",
    },

    {
        "stevearc/overseer.nvim",
        config = function()
            require("user.overseer").config()
        end,
        enabled = lvim.builtin.task_runner == "overseer",
    },

    -- kdl.vim
    { "imsnif/kdl.vim" },
    -- Justfile
    { "NoahTheDuke/vim-just", ft = "just" },

    -- Treesitter textobject
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        event = "BufReadPre",
        dependencies = "nvim-treesitter",
    },

    -- Powerful tab
    {
        "abecodes/tabout.nvim",
        config = function()
            require("user.tabout").config()
        end,
    },
}
