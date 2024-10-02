-- Additional Plugins
local themes = require("user.builtin").themes
local get_theme = require("user.builtin").get_theme

lvim.plugins = {
    -------------------------
    --        theme        --
    -------------------------
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("user.theme").nightfox()
        end,
        cond = function()
            return (get_theme() == themes.nightfox)
        end,
    },

    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("user.theme").kanagawa()
        end,
        cond = function()
            return (get_theme() == themes.kanagawa)
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("user.theme").rose_pine()
        end,
        cond = function()
            return (get_theme() == themes.rose_pine)
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("user.theme").catppuccin()
        end,
        cond = function()
            return (get_theme() == themes.catppuccin)
        end,
    },

    -----------------------------
    --        operation        --
    -----------------------------
    { "machakann/vim-sandwich" },
    -- { "echasnovski/mini.surround", version = false, config = true },

    -----------------------
    --        lsp        --
    -----------------------

    -- cpp
    { "p00f/clangd_extensions.nvim" },
    { "Civitasv/cmake-tools.nvim" },

    -- rust
    { "rust-lang/rust.vim" },

    {
        "mrcjkb/rustaceanvim",
        lazy = false,
    },

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
                popup = {
                    style = "minimal",
                    border = "rounded",
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
            require("todo-comments").setup({})
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
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { -- Example mapping to toggle outline
            { "<leader>ly", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        config = function()
            require("user.outline").config()
        end,
    },

    -- show lsp progress
    {
        "j-hui/fidget.nvim",
        config = function()
            require("user.fidget").config()
        end,
    },

    {
        "b0o/incline.nvim",
        config = function()
            require("user.incline").config()
        end,
        enabled = lvim.builtin.breadcrumbs_provider == "incline",
    },

    {
        "Bekaboo/dropbar.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        enabled = lvim.builtin.breadcrumbs_provider == "dropbar",
    },

    -- show lsp signature
    {
        "ray-x/lsp_signature.nvim",
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

    -- trouble
    {
        "folke/trouble.nvim",
        config = function()
            require("user.trouble").config()
        end,
        cmd = "Trouble",
        event = "VeryLazy",
        enabled = lvim.builtin.trouble.active,
    },

    -- latex and markdown
    -- {
    --     "OXY2DEV/markview.nvim",
    --     lazy = false,
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-tree/nvim-web-devicons",
    --     },
    -- },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {},
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    },

    { "barreiroleo/ltex-extra.nvim" },
    {
        "Kicamon/markdown-table-mode.nvim",
        config = function()
            require("markdown-table-mode").setup()
        end,
    },
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
        lazy = false,
        init = function()
            require("user.vimtex").config()
        end,
    },

    {
        "iurimateus/luasnip-latex-snippets.nvim",
        -- vimtex isn't required if using treesitter
        dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
        config = function()
            require("luasnip-latex-snippets").setup({ use_treesitter = true })
        end,
    },

    -- find alternaitve word synonyms
    {
        "Ron89/thesaurus_query.vim",
    },

    -- translator
    -- https://github.com/voldikss/vim-translator#know-bugs
    -- alternative https://github.com/potamides/pantran.nvim
    {
        "voldikss/vim-translator",
        config = function()
            require("user.vim-translator").config()
        end,
    },
    {
        "micangl/cmp-vimtex",
        config = function()
            require("cmp_vimtex").setup({
                search = {
                    browser = "open",
                },
            })
        end,
    },

    -- Cmp for emojis..
    { "hrsh7th/cmp-emoji" },

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

    -----------------------------------
    --        session manager        --
    -----------------------------------

    {
        "olimorris/persisted.nvim",
        config = function()
            require("user.persisted").config()
        end,
    },

    --  manage issues and pr
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        lazy = true,
        cmd = "Octo",
        config = function()
            require("user.octo").config()
        end,
    },

    -- Git linker
    {
        "ruifm/gitlinker.nvim",
        event = "BufRead",
        config = function()
            require("user.gitlinker").config()
        end,
        dependencies = "nvim-lua/plenary.nvim",
    },

    -- Refactoring
    {
        "ThePrimeagen/refactoring.nvim",
        ft = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "rust", "kotlin" },
        lazy = true,
        config = function()
            require("user.refactoring").config()
        end,
        enabled = lvim.builtin.refactoring,
    },

    {
        url = "https://github.com/abzcoding/lsp_lines.nvim",
        config = function()
            require("user.lsplines").config()
        end,
        enabled = lvim.builtin.lsplines,
    },

    {
        "stevearc/dressing.nvim",
        config = function()
            require("user.dressing").config()
        end,
    },

    {
        "cshuaimin/ssr.nvim",
        -- Calling setup is optional.
        config = function()
            require("user.ssr").config()
        end,
        lazy = true,
        enabled = lvim.builtin.ssr.ctive,
    },

    ----------------------------
    --        zen mode        --
    ----------------------------

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

    -- smooth scroll
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
                keymaps = { basic = true, extra = true },
                options = {
                    mode = "window",
                },
            })
        end,
        event = "BufRead",
        enabled = lvim.builtin.smooth_scroll == "cinnamon",
    },

    ---------------------------------------
    --        telescope extension        --
    ---------------------------------------
    -- Telescope zoxide
    {
        "jvgrootveld/telescope-zoxide",
        dependencies = { "nvim-telescope/telescope.nvim" },
        lazy = true,
    },
    {
        "cljoly/telescope-repo.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = true,
    },

    -- Telescope file browser
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        lazy = true,
    },

    -- Telescope plugins for lazy.nvim
    { "tsakirist/telescope-lazy.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

    {
        "danielfalk/smart-open.nvim",
        dependencies = {
            "kkharji/sqlite.lua",
            "nvim-telescope/telescope-fzy-native.nvim",
            "nvim-telescope/telescope.nvim",
        },
        lazy = true,
    },

    { "nvim-telescope/telescope-bibtex.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

    -------------------------
    --        noice        --
    -------------------------

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("user.noice").config()
        end,
        dependencies = {
            "rcarriga/nvim-notify",
            "MunifTanjim/nui.nvim",
        },
        enabled = lvim.builtin.noice.active,
    },

    --------------------------
    --        others        --
    --------------------------

    -- {
    --     "krivahtoo/silicon.nvim",
    --     build = "./install.sh build",
    --     config = function()
    --         require("user.silicon").config()
    --     end,
    --     event = "VeryLazy",
    --     cmd = "Silicon",
    -- },

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
        cmd = {
            "CECompile",
            "CECompileLive",
            "CEFormat",
            "CEAddLibrary",
            "CELoadExample",
            "CEOpenWebsite",
            "CEDeleteCache",
            "CEShowTooltip",
            "CEGotoLabel",
        },
        event = "VeryLazy",
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

    {
        "nvim-neotest/neotest",
        config = function()
            require("user.ntest").config()
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-plenary",
        },
        event = { "BufReadPost", "BufNew" },
        enabled = lvim.builtin.task_runner == "overseer",
    },

    -- { "nvim-neotest/neotest-go", event = { "BufEnter *.go" } },
    {
        "nvim-neotest/neotest-python",
        event = { "BufEnter *.py" },
        enabled = lvim.builtin.task_runner == "overseer",
    },

    {
        "rouge8/neotest-rust",
        event = { "BufEnter *.rs" },
        enabled = lvim.builtin.task_runner == "overseer",
    },

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
                commands = {
                    toggle_comment_debug_prints = "ToggleCommentDebugPrints",
                    delete_debug_prints = "DeleteDebugPrints",
                },
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
                print_tag = "DBG-YYL",
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
                    languages = { "r", "python", "julia", "bash", "html" },
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
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
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup()
        end,
    },

    -- Better hl
    {
        "m-demare/hlargs.nvim",
        config = function()
            require("hlargs").setup({
                excluded_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
            })
        end,
        lazy = true,
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },

    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp",
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        opts = {
            -- Your options go here
            -- name = "venv",
            -- auto_refresh = false
        },
        event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        keys = {
            -- Keymap to open VenvSelector to pick a venv.
            -- { "<leader>vs", "<cmd>VenvSelect<cr>" },
            -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
            -- { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
        },
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
        init = function()
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        end,
        config = function()
            require("user.ufo").config()
        end,
        enabled = lvim.builtin.ufo.active,
    },

    {
        "luukvbaal/statuscol.nvim",
        config = function()
            require("user.statuscol").config()
        end,
        enabled = lvim.builtin.ufo.active,
    },

    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    -- kdl.vim
    { "imsnif/kdl.vim" },
    { "szebniok/tree-sitter-wgsl" },
    { "ziglang/zig.vim" },
    { "ron-rs/ron.vim" },
    { "NoahTheDuke/vim-just" },
    -- Highligh logs
    {
        "mtdl9/vim-log-highlighting",
        ft = { "text", "log" },
        lazy = true,
    },

    {
        "subnut/nvim-ghost.nvim",
        config = function()
            vim.cmd([[
            " Multiple autocommands can be specified like so -
            augroup nvim_ghost_user_autocommands
              au User www.reddit.com,www.stackoverflow.com setfiletype markdown
              au User www.reddit.com,www.github.com setfiletype markdown
              au User *github.com setfiletype markdown
              au User www.overleaf.com setfiletype tex
            augroup END
            ]])
        end,
    },

    {
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim" },
        config = function()
            require("compiler").setup()
        end,
    },

    { "jose-elias-alvarez/typescript.nvim" },

    {
        "piersolenski/wtf.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        event = "VeryLazy",
        opts = {
            popup_type = "vertical",
        },
        keys = {
            {
                "gw",
                mode = { "n", "x" },
                function()
                    require("wtf").ai()
                end,
                desc = "Debug diagnostic with AI",
            },
            {
                mode = { "n", "x" },
                "gW",
                function()
                    require("wtf").search()
                end,
                desc = "Search diagnostic with Google",
            },
        },
        enabled = lvim.builtin.chatgpt.active,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = require("user.flash").keys,
        enabled = lvim.builtin.motion_provider == "flash",
    },

    -- typst
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
        config = function()
            vim.g.typst_pdf_viewer = "skim"
        end,
        enabled = lvim.builtin.typst.active,
    },

    {
        "MrPicklePinosaur/typst-conceal.vim",
        ft = "typst",
        config = function()
            vim.g.typst_conceal_math = 1
            vim.g.typst_conceal_emoji = 1
        end,
        enabled = lvim.builtin.typst.active,
    },
    -- typst

    {
        "2kabhishek/nerdy.nvim",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Nerdy",
    },

    {
        "Wansmer/symbol-usage.nvim",
        event = "LspAttach", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
        config = function()
            require("user.symbol_usage").config()
        end,
        enabled = lvim.builtin.symbol_usage.active,
    },

    -- Preview code actions
    {
        "aznhe21/actions-preview.nvim",
        lazy = true,
        config = function()
            require("actions-preview").setup({
                telescope = {
                    sorting_strategy = "ascending",
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.8,
                        height = 0.9,
                        prompt_position = "top",
                        preview_cutoff = 20,
                        preview_height = function(_, _, max_lines)
                            return max_lines - 20
                        end,
                    },
                },
            })
            vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
        end,
    },

    -- others

    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        -- Author's Note: If default keymappings fail to register (possible config issue in my local setup),
        -- verify lazy loading functionality. On failure, disable lazy load and report issue
        -- lazy = false,
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
        end,
        keys = {
            { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
        },
    },

    {
        "HakonHarnes/img-clip.nvim",
        event = "BufEnter",
        keys = {
            -- suggested keymap
            { "gpI", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
        },
    },

    {
        "echasnovski/mini.align",
        event = "VeryLazy",
        version = false,
        config = function()
            require("mini.align").setup()
        end,
        enabled = false,
    },

    { "kilavila/nvim-gitignore" },

    {
        "let-def/texpresso.vim",
    },
}
