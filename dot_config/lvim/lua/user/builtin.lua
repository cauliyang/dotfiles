-- ref1:  https://github.com/crisidev/dotfiles/blob/main/home/.config/lvim/lua/user/plugins.lua
-- ref2: https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/init.lua
local M = {}

M.themes = {
    rose_pine = "rose-pine",
    lunar = "lunar",
    nightfox = "nightfox",
    kanagawa = "kanagawa",
    gruvbox_material = "gruvbox-material",
    gruvbox_baby = "gruvbox-baby",
    onedarker = "onedarker",
    tokyonight = "tokyonight",
    tokyonight_night = "tokyonight-night",
    tokyonight_day = "tokyonight-day",
    tokyonight_moon = "tokyonight-moon",
    catppuccin = "catppuccin",
    miasma = "miasma",
}

M.get_theme = function(default)
    if default ~= nil then
        return default
    end

    local _time = os.date("*t")
    if (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1) then
        return M.themes.kanagawa
    elseif _time.hour >= 1 and _time.hour < 9 then
        return M.themes.rose_pine
    elseif _time.hour >= 17 and _time.hour < 21 then
        return M.themes.catppuccin
    else
        return M.themes.nightfox
    end
end

M.config = function()
    lvim.log.level = "warn"
    lvim.format_on_save.enabled = true

    lvim.colorscheme = M.get_theme()
    lvim.builtin.time_based_themes = true

    lvim.transparent_window = true

    -- to disable icons and use a minimalist setup, uncomment the following
    lvim.use_icons = true
    -- keymappings [view all the defaults by pressing <leader>Lk]
    lvim.leader = "space"
    -- add your own keymapping
    -- lvim.keys.normal_mode["<C-s>"] = "<Cmd>w<cr>"
    lvim.keys.normal_mode["<S-l>"] = "<Cmd>BufferLineCycleNext<CR>"
    lvim.keys.normal_mode["<S-h>"] = "<Cmd>BufferLineCyclePrev<CR>"
    lvim.keys.insert_mode["jk"] = "<ESC>"

    lvim.keys.normal_mode["gpm"] = "<Cmd>MarkdownPreviewToggle<CR>"
    lvim.keys.normal_mode["gpe"] = "<Cmd>lua require('nabla').popup()<CR>"

    -- center the cursor when scrolling
    lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
    lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
    -- do not copy in visual mode  when pasting
    lvim.keys.visual_mode["p"] = '"_dP'

    -- After changing plugin config exit and reopen LunarVim,
    -- lvim.builtin.borderless_cmp = true

    lvim.builtin.alpha.active = true
    lvim.builtin.alpha.mode = "dashboard"

    lvim.builtin.cmp.cmdline.enable = true

    lvim.builtin.bigfile.active = true
    lvim.builtin.dap.active = true
    lvim.builtin.terminal.active = true
    lvim.builtin.nvimtree.setup.view.side = "left"
    lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
    lvim.builtin.treesitter.highlight.enabled = true

    lvim.lsp.installer.setup.automatic_installation = false

    -----------------------------
    --        which key        --
    -----------------------------

    lvim.builtin.which_key.setup.window.winblend = 10
    lvim.builtin.which_key.setup.window.border = "none"
    lvim.builtin.which_key.setup.plugins.presets.z = true
    lvim.builtin.which_key.setup.plugins.presets.f = true
    lvim.builtin.which_key.setup.plugins.presets.windows = true
    lvim.builtin.which_key.setup.plugins.presets.nav = true
    lvim.builtin.which_key.setup.plugins.marks = true
    lvim.builtin.which_key.setup.plugins.registers = true
    -- lvim.builtin.which_key.setup.triggers = { "<leader>", "<space>", "f", "z", "]", "[" }
    lvim.builtin.which_key.setup.ignore_missing = false

    ------------------------
    --        opts        --
    ------------------------
    vim.g.instant_username = vim.env.USER

    -----------------------------
    --        dashboard        --
    -----------------------------

    lvim.builtin.alpha.mode = "custom"
    local alpha_opts = require("user.dashboard").config()
    lvim.builtin.alpha["custom"] = { config = alpha_opts }

    -----------------------------
    --        telescope        --
    -----------------------------

    ------------------------
    --        plugins     --
    ------------------------
    lvim.builtin.lsplines = true
    -- Global status line
    lvim.builtin.global_statusline = true
    -- test runner
    lvim.builtin.test_runner = ""
    -- task runner
    lvim.builtin.task_runner = "overseer" -- overseer
    -- tree provider
    lvim.builtin.tree_provider = "nvimtree"
    -- tag provider
    lvim.builtin.tag_provider = "symbols-outline"
    -- motion provider
    lvim.builtin.motion_provider = ""
    -- image viewer
    lvim.builtin.image_viewer = "" -- chafa
    -- note provider
    lvim.builtin.note = "mind" -- mind or telekasten
    lvim.builtin.ufo = { active = true }

    lvim.builtin.copilot = { active = true }
    lvim.builtin.trouble = { active = true }
    lvim.builtin.distant = { active = false }

    lvim.builtin.borderless_cmp = true

    -- Noice
    lvim.builtin.noice = {
        active = false,
        lsp_progress = false,
    }

    -- zen mode
    lvim.builtin.zen = { active = true }
    lvim.builtin.twilight = { active = true }
    -- search and replace
    lvim.builtin.ssr = { active = true }
    -- snapshot
    lvim.builtin.vimsilicon = { active = false }
    -- ui
    lvim.builtin.noice = { active = false }
    -- sniprun
    -- https://github.com/michaelb/sniprun
    lvim.builtin.sniprun = { active = false }

    -- smooth_scroll
    lvim.builtin.smooth_scroll = "" -- value can be  "neoscroll" . "cinnamon" or ""
    -- refactoring
    lvim.builtin.refactoring = { active = true }
    lvim.builtin.chatgpt = { active = true }
    lvim.builtin.frontend = { active = true }
    lvim.builtin.typst = { active = true }

    lvim.builtin.breadcrumbs_provider = "incline" -- 'dropbar'
    if lvim.builtin.breadcrumbs_provider == "none" then
        lvim.builtin.breadcrumbs.active = true
    else
        lvim.builtin.breadcrumbs.active = false
    end
end

return M
