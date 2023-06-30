-- Additional Plugins

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
        "luisiacc/gruvbox-baby",
        config = function()
            -- Enable telescope theme
            vim.g.gruvbox_baby_telescope_theme = 1
            -- Enable transparent mode
            vim.g.gruvbox_baby_transparent_mode = 1
            vim.g.gruvbox_baby_background_color = "dark"
        end,

        enabled = lvim.builtin.theme.name == "gruvbox-baby",
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
        branch = "legacy",
        config = function()
            require("user.fidget").config()
        end,
    },

    {
        "b0o/incline.nvim",
        config = function()
            require("user.incline").config()
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
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            vim.defer_fn(function()
                require("copilot").setup({
                    plugin_manager_path = get_runtime_dir() .. "/site/pack/lazy",
                    filetypes = {
                        yaml = false,
                        help = false,
                        gitcommit = false,
                        gitrebase = false,
                        hgcommit = false,
                        svn = false,
                        cvs = false,
                        ["."] = false,
                        ["*"] = true,
                    },
                }) -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
                require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
            end, 100)
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

    -- -- Glow markdown preview
    -- {
    --     "ellisonleao/glow.nvim",
    --     config = function()
    --         require("glow").setup()
    --     end,
    --     ft = { "markdown" },
    -- },

    { "barreiroleo/ltex-extra.nvim" },

    {
        "AckslD/nvim-FeMaco.lua",
        config = function()
            require("femaco").setup()
        end,
    },

    -- show math equation
    {
        "jbyuki/nabla.nvim",
        config = function()
            vim.api.nvim_create_user_command("TexToggleMath", function()
                require("nabla").enable_virt()
            end, {})
        end,
    },

    {
        "SidOfc/mkdx",
        config = function()
            require("user.mkdx").config()
        end,
    },
    -- support  markdown citation
    {
        "jalvesaq/zotcite",
        dependencies = "jalvesaq/cmp-zotcite",
    },

    {
        "lervag/vimtex",
        config = function()
            require("user.vimtex").config()
        end,
        lazy = false,
    },

    {
        "Ron89/thesaurus_query.vim",
    },

    -- -- -- note
    -- -- -- https://github.com/renerocksai/telekasten.nvim

    -- translator
    -- https://github.com/voldikss/vim-translator#know-bugs
    -- alternative https://github.com/potamides/pantran.nvim
    {
        "voldikss/vim-translator",
        config = function()
            require("user.vim-translator").config()
        end,
    },

    -- -- Translate
    -- {
    --     "potamides/pantran.nvim",
    --     lazy = true,
    --     cmd = "Pantran",
    --     confg = function()
    --         require("pantran").setup({
    --             default_engine = "argos",
    --             engines = {
    --                 argos = {
    --                     default_source = "en",
    --                     default_target = "cn",
    --                 },
    --             },
    --         })
    --     end,
    -- },

    {
        "hrsh7th/cmp-omni",
    },
    -- -- Cmp for emojis..
    { "hrsh7th/cmp-emoji" },

    -- -- Cmp for to calculate maths expressions.
    -- { "hrsh7th/cmp-calc" },

    -- cmp_dictionay
    -- https://github.com/uga-rosa/cmp-dictionary/wiki/Examples-of-usage
    {
        "uga-rosa/cmp-dictionary",
        config = function()
            require("cmp_dictionary").setup({
                dic = {
                    ["tex"] = "/Users/ylk4626/.config/dict/en.dict",
                    ["markdown"] = "/Users/ylk4626/.config/dict/en.dict",
                    ["rst"] = "/Users/ylk4626/.config/dict/en.dict",
                    ["*"] = {},
                },
            })
        end,
        lazy = true,
    },

    -- Cmp for github/gitlab issues
    {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("cmp_git").setup()
        end,
        lazy = true,
    },

    -- cmp for lsp signature help
    { "hrsh7th/cmp-nvim-lsp-signature-help" },

    {
        "kdheepak/cmp-latex-symbols",
        dependencies = "hrsh7th/nvim-cmp",
        ft = "tex",
    },

    -- -- -----------------------------------
    -- -- --        session manager        --
    -- -- -----------------------------------

    {
        "olimorris/persisted.nvim",
        -- lazy = true,
        config = function()
            require("user.persisted").config()
        end,
    },

    -- {
    --     "pwntester/octo.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    --     lazy = true,
    --     cmd = "Octo",
    --     config = function()
    --         require("user.octo").config()
    --     end,
    -- },

    -- Git linker
    {
        "ruifm/gitlinker.nvim",
        event = "BufRead",
        config = function()
            require("gitlinker").setup({
                opts = {
                    -- adds current line nr in the url for normal mode
                    add_current_line_on_normal_mode = true,
                    -- callback for what to do with the url
                    action_callback = require("gitlinker.actions").copy_to_clipboard,
                    -- print the url after performing the action
                    print_url = false,
                    -- mapping to call url generation
                    mappings = nil,
                },
            })
        end,
        dependencies = "nvim-lua/plenary.nvim",
    },
    ---------------

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

    -- -- -- neotest
    -- -- -- { "nvim-neotest/neotest-python", event = { "BufEnter *.py" } },
    -- -- -- { "rouge8/neotest-rust", event = { "BufEnter *.rs" } },
    -- -- -- {
    -- -- -- 	"nvim-neotest/neotest",
    -- -- -- 	config = require("user.neotest").post(),
    -- -- -- 	dependencies = { "nvim-neotest/neotest-plenary" },
    -- -- -- 	event = { "BufReadPost", "BufNew" },
    -- -- -- },
    -- -- -- { "nvim-neotest/neotest-go", event = { "BufEnter *.go" } },
    -- --  https://github.com/cshuaimin/ssr.nvim/

    {
        "cshuaimin/ssr.nvim",
        -- Calling setup is optional.
        config = function()
            require("user.ssr").config()
        end,
        lazy = true,
        enabled = lvim.builtin.ssr.ctive,
    },

    -- -- ----------------------------
    -- -- --        zen mode        --
    -- -- ----------------------------

    {
        "folke/zen-mode.nvim",
        config = function()
            require("user.zen").config()
        end,
        enabled = lvim.builtin.zen.active,
    },

    {
        "folke/twilight.nvim",
        config = function()
            require("user.twilight").config()
        end,
        cmd = "Twilight",
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

    -- -- ---------------------------------------
    -- -- --        telescope extension        --
    -- -- ---------------------------------------

    -- -- { "nanotee/zoxide.vim" },

    -- -- {
    -- --     "jvgrootveld/telescope-zoxide",
    -- --     dependencies = { "nvim-telescope/telescope.nvim" },
    -- --     lazy = true,
    -- -- },

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

    -- -- Telescope plugins for lazy.nvim
    { "tsakirist/telescope-lazy.nvim" },

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

    { "nvim-telescope/telescope-bibtex.nvim" },

    -- -------------------------
    -- --        noice        --
    -- -------------------------

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

    -- --------------------------
    -- --        others        --
    -- --------------------------

    -- {
    --     "krivahtoo/silicon.nvim",
    --     build = "./install.sh build",
    --     config = function()
    --         require("user.silicon").config()
    --     end,
    --     event = "VeryLazy",
    -- },

    -- -- {
    -- --     "glacambre/firenvim",
    -- --     build = function()
    -- --         vim.fn----[[ [[ ["firenvim#install"] ]] ]](0)
    -- --     end,
    -- -- },

    ----------------------------
    --        Daily Life        --
    ----------------------------
    {
        "renerocksai/telekasten.nvim",
        config = function()
            require("user.telekasten").config()
        end,
        enabled = lvim.builtin.note == "telekasten",
        event = "VeryLazy",
    },
    -- -- Trouble
    -- {
    --     "folke/trouble.nvim",
    --     config = function()
    --         require("trouble").setup({
    --             auto_open = false,
    --             auto_close = true,
    --             padding = false,
    --             height = 10,
    --             use_diagnostic_signs = true,
    --         })
    --     end,
    --     cmd = "Trouble",
    --     event = "VeryLazy",
    --     enabled = lvim.builtin.trouble.active,
    -- },

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
        -- lazy = true,
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

    {
        "jackMort/ChatGPT.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("chatgpt").setup({
                popup_input = { submit = "<C-b>" },
            })
        end,
        event = "VeryLazy",
        enabled = lvim.builtin.chatgpt.active,
    },

    {
        "stevearc/overseer.nvim",
        config = function()
            require("user.overseer").config()
        end,
        enabled = lvim.builtin.task_runner == "overseer",
    },

    -- -- -- kdl.vim
    { "imsnif/kdl.vim" },

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

    {
        "chipsenkbeil/distant.nvim",
        config = function()
            require("distant").setup({
                -- Applies Chip's personal settings to every machine you connect to
                --
                -- 1. Ensures that distant servers terminate with no connections
                -- 2. Provides navigation bindings for remote directories
                -- 3. Provides keybinding to jump into a remote file's parent directory
                ["*"] = require("distant.settings").chip_default(),
                ["quser32.ci.northwestern.edu"] = {
                    mode = "ssh",
                    ssh = {
                        user = "ylk4626",
                    },
                },
            })
        end,
        lazy = true,
        enabled = lvim.builtin.distant.active,
    },

    {
        "andrewferrier/debugprint.nvim",
        config = function()
            require("debugprint").setup({
                create_keymaps = true,
                create_commands = true,
                move_to_debugline = true,
                display_snippet = true,
                display_counter = true,
                filetypes = {
                    ["rust"] = {
                        left = 'dbg!("',
                        right = '");',
                        mid_var = '{:?}", &',
                        right_var = ");",
                    },
                },
                print_tag = "DBG-CRISIDEV",
            })
        end,
    },

    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("quarto").setup({
                lspFeatures = {
                    enabled = true,
                    languages = { "r", "python", "julia" },
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWrite" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
            })
        end,
    },

    {
        "willothy/flatten.nvim",
        config = true,
        -- or pass configuration with
        -- opts = {  }
        -- Ensure that it runs first to minimize delay when opening file from terminal
        lazy = false,
        priority = 1001,
    },

    {
        "mfussenegger/nvim-dap-python",
    },

    {
        "glacambre/firenvim",
        -- Lazy load firenvim
        -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
        cond = not not vim.g.started_by_firenvim,
        build = function()
            require("lazy").load({ plugins = "firenvim", wait = true })
            vim.fn["firenvim#install"](0)
        end,
        config = function()
            vim.g.firenvim_config = {
                globalSettings = { alt = "all" },
                localSettings = {
                    [".*"] = {
                        cmdline = "neovim",
                        content = "text",
                        priority = 0,
                        selector = "textarea",
                        takeover = "never",
                    },
                },
            }
        end,
    },

    {
        "Bryley/neoai.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = {
            "NeoAI",
            "NeoAIOpen",
            "NeoAIClose",
            "NeoAIToggle",
            "NeoAIContext",
            "NeoAIContextOpen",
            "NeoAIContextClose",
            "NeoAIInject",
            "NeoAIInjectCode",
            "NeoAIInjectContext",
            "NeoAIInjectContextCode",
        },

        -- keys = {
        --     { "<leader>as", desc = "summarize text" },
        --     { "<leader>ag", desc = "generate git message" },
        -- },
        keys = nil,

        config = function()
            require("neoai").setup({
                -- Options go here
            })
        end,
    },

    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },

    {
        "AckslD/swenv.nvim",
        config = function()
            require("swenv").setup()
        end,
    },
    {
        "jinh0/eyeliner.nvim",
        config = function()
            require("eyeliner").setup({
                highlight_on_key = true, -- show highlights only after keypress
                dim = true, -- dim all other characters if set to true (recommended!)
            })
        end,
    },

    {

        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("ufo").setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { "treesitter", "indent" }
                end,
            })
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
            vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
        end,
        enabled = lvim.builtin.ufo.active,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    { "szebniok/tree-sitter-wgsl" },

    { "IndianBoy42/tree-sitter-just" },
}
