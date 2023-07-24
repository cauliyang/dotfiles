local M = {}

M.session_load_last = function()
    require("persisted").load({ last = true })
end

M.smart_quit = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")

    -- vim.cmd("Neotree close")

    if modified then
        vim.ui.input({
            prompt = "You have unsaved changes. Quit anyway? (y/n) ",
        }, function(input)
            if input == "y" then
                vim.cmd("q!")
            end
        end)
    else
        vim.cmd("q!")
    end
end

M.config = function()
    local kind = require("user.lsp_kind")
    local icons = require("user.icons").icons

    local header = {
        type = "text",
        val = require("user.banners").dashboard(),
        opts = {
            position = "center",
            hl = "Comment",
        },
    }

    local plugins = ""
    local date = os.date("%a %d %b")
    if vim.fn.has("linux") == 1 or vim.fn.has("mac") == 1 then
        local handle =
            io.popen('fd -d 2 . $HOME"/.local/share/lunarvim/site/pack/lazy" | grep pack | wc -l | tr -d "\n" ')
        plugins = handle:read("*a")
        handle:close()

        plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
    else
        plugins = "N/A"
    end

    local plugin_count = {
        type = "text",
        val = "└─ "
            .. icons.Package
            .. " "
            .. string.format("% 4d", plugins)
            .. " plugins 󰄛 "
            .. vim.version().major
            .. "."
            .. vim.version().minor
            .. "."
            .. vim.version().patch
            .. " ─┘",
        opts = {
            position = "center",
            hl = "String",
        },
    }

    local heading = {
        type = "text",
        val = "┌─ " .. kind.icons.calendar .. " Today is " .. date .. " ─┐",
        opts = {
            position = "center",
            hl = "String",
        },
    }

    local fortune = require("alpha.fortune")()
    -- fortune = fortune:gsub("^%s+", ""):gsub("%s+$", "")
    local footer = {
        type = "text",
        val = fortune,
        opts = {
            position = "center",
            hl = "Comment",
            hl_shortcut = "Comment",
        },
    }

    local function button(sc, txt, keybind)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

        local opts = {
            position = "center",
            text = txt,
            shortcut = sc,
            cursor = 5,
            width = 24,
            align_shortcut = "right",
            hl_shortcut = "Number",
            hl = "Function",
        }
        if keybind then
            opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
        end

        return {
            type = "button",
            val = txt,
            on_press = function()
                local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
                vim.api.nvim_feedkeys(key, "normal", false)
            end,
            opts = opts,
        }
    end

    local buttons = {
        type = "group",

        val = {

            button("r", icons.clock .. " Smart open", "<cmd>lua require('user.telescope').smart_open()<cr>"),
            button("l", icons.magic .. " Last session", "<cmd>lua require('user.dashboard').session_load_last()<cr>"),
            button("S", icons.session .. " Sessions", "<cmd>lua require('user.telescope').session()<cr>"),
            button("z", icons.folder .. "  Zoxide", "<cmd>lua require('user.telescope').zoxide()<cr>"),
            button(
                "f",
                kind.cmp_kind.File .. " Find file",
                "<cmd>lua require('user.telescope').find_project_files()<cr>"
            ),
            button("s", icons.text .. "  Find word", "<cmd>lua require('user.telescope').find_string()<cr>"),
            button("n", icons.stuka .. " New file", "<cmd>ene <BAR> startinsert <cr>"),
            button("b", icons.files .. " File browser", "<cmd>lua require('user.telescope').file_browser()<cr>"),
            button("p", icons.project .. " Projects", "<cmd>lua require('user.telescope').projects()<cr>"),
            button("q", icons.exit .. " Quit", "<cmd>lua require('user.dashboard').smart_quit()<cr>"),
            button("c", icons.config .. " Config", "<cmd>e ~/.config/lvim/config.lua<cr>"),
        },

        opts = {
            spacing = 1,
        },
    }

    local section = {
        header = header,
        buttons = buttons,
        plugin_count = plugin_count,
        heading = heading,
        footer = footer,
    }

    local opts = {
        layout = {
            { type = "padding", val = 1 },
            section.header,
            { type = "padding", val = 2 },
            section.heading,
            section.plugin_count,
            { type = "padding", val = 1 },
            -- section.top_bar,
            section.buttons,
            -- section.bot_bar,
            -- { type = "padding", val = 1 },
            section.footer,
        },
        opts = {
            margin = 5,
        },
    }
    return opts
end

return M
