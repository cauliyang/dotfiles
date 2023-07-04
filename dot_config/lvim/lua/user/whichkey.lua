lvim.builtin.which_key.mappings["T"] = nil

local icons = require("user.icons").icons

lvim.builtin.which_key.mappings["L"]["name"] = icons.moon .. " Lunarvim"

if lvim.builtin.trouble.active then
    lvim.builtin.which_key.mappings["t"] = {
        name = "Trouble",
        r = { "<cmd>Trouble lsp_references<cr>", "References" },
        f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
        d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
        q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
        l = { "<cmd>Trouble loclist<cr>", "LocationList" },
        w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
    }
end

if lvim.builtin.task_runner == "overseer" then
    lvim.builtin.which_key.mappings["O"] = {
        name = "Overseer",
        l = { "<cmd>OverseerLoadBundle<CR>", "Load Bundle" },
        s = { "<cmd>OverseerSaveBundle<CR>", "Save Bundle" },
        n = { "<cmd>OverseerBuild<CR>", "New Task" },
        q = { "<cmd>OverseerQuickAction<CR>", "Quick Action" },
        f = { "<cmd>OverseerTaskAction<CR>", "Task Action" },
        t = { "<cmd>OverseerToggle<cr>", "Toggle Output" },
        r = { "<cmd>OverseerRun<cr>", "Run" },
        R = { "<cmd>OverseerRunCmd<cr>", "Run with Cmd" },
    }
end

if lvim.builtin.note == "telekasten" then
    lvim.builtin.which_key.mappings["N"] = {
        name = "Notes",
        c = { "<cmd>Telekasten show_calendar<cr>", "Calendar" },
        n = { "<cmd>Telekasten new_note<cr>", "Note" },
        f = { "<cmd>Telekasten find_notes<cr>", "Find" },
        F = { "<cmd>Telekasten find_daily_notes<cr>", "Find Journal" },
        j = { "<cmd>Telekasten goto_today<cr>", "Journal" },
        p = { "<cmd>Telekasten panel<cr>", "Panel" },
        t = { "<cmd>Telekasten toggle_todo<cr>", "Toggle Todo" },
    }
end

if lvim.builtin.refactoring.active then
    lvim.builtin.which_key.mappings["r"] = {
        name = "Refactor",
        f = { "<cmd>lua require('refactoring').refactor('Extract Function')<cr>", "Extract function" },
        F = {
            "<cmd>lua require('refactoring').refactor('Extract Function To File')<cr>",
            "Extract function to file",
        },
        v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<cr>", "Extract variable" },
        i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<cr>", "Inline variable" },
        b = { "<cmd>lua require('refactoring').refactor('Extract Block')<cr>", "Extract block" },
        B = {
            "<cmd>lua require('refactoring').refactor('Extract Block To File')<cr>",
            "Extract block to file",
        },
    }
end

lvim.builtin.which_key.mappings["n"] = {
    name = "Neogen",
    c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
    f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
    t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
    F = { "<cmd>lua require('neogen').generate({ type = 'file'})<CR>", "File Documentation" },
}

lvim.builtin.which_key.mappings["F"] = {
    name = "Find",
    f = { "<cmd>lua require('user.telescope').find_files()<cr>", "Find files" },
    F = { "<cmd>lua require('user.telescope').search_only_certain_files()<cr>", "File certain filetype" },
    b = { "<cmd>lua require('user.telescope').file_browser()<cr>", "File browser" },
    p = { "<cmd>lua require('user.telescope').projects()<cr>", "Projects" },
    s = { "<cmd>lua require('user.telescope').find_string()<cr>", "Find string" },
    S = { "<cmd>lua require('user.telescope').find_identifier()<cr>", "Find identifier under cursor" },
    r = { "<cmd>lua require('user.telescope').recent_files()<cr>", "Recent files" },
    o = { "<cmd>lua require('user.telescope').smart_open()<cr>", "Smart open" },
    y = { "<cmd>lua require('user.telescope').neoclip()<cr>", "Clipboard" },
    l = { "<cmd>lua require('user.telescope').luasnip()<cr>)", "Luasnip" },
    g = { "<cmd>lua require('user.telescope').lazy()<cr>)", "Lazy Plugins" },
    t = { "<cmd>lua require('user.telescope').resume()<cr>", "Last sction" },
    c = { "<cmd>lua require('user.telescope').bibtex()<cr>", "Find citation" },
}

-- Sessions
lvim.builtin.which_key.mappings["S"] = {
    name = "Session",
    l = { "<cmd>lua require('user.telescope').session()<cr>", "List available sessions" },
    d = { "<cmd>SessionDelete<cr>", "Delete session" },
    L = { "<cmd>SessionLoadLast<cr>", "Restore last session" },
    c = { "<cmd>SessionLoad<cr>", "Restore current dir session" },
    s = { "<cmd>SessionSave<cr>", "Save current session" },
}

lvim.builtin.which_key.mappings["sx"] = {
    { "<cmd>lua require('ssr').open()<cr>", "structure replace" },
}

lvim.builtin.which_key.mappings["ly"] = {
    "<cmd>SymbolsOutline<CR>",
    "SymbolsOutline",
}

lvim.builtin.which_key.mappings["gS"] = {
    "<cmd>lua require('user.telescope').git_status()<cr>",
    "Repository status",
}

lvim.builtin.which_key.mappings["gf"] = {
    "<cmd>lua require('user.telescope').git_files()<cr>",
    "Repository files",
}

lvim.builtin.which_key.vmappings["s"] = {
    "<cmd>lua require('user.telescope').find_string_visual()<cr>",
    "Find string",
}

lvim.builtin.which_key.mappings["lp"] = { { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP Lines" } }
lvim.builtin.which_key.mappings["lo"] = { { "<cmd>lua vim.lsp.inlay_hint(0)<cr>", icons.inlay .. "Toggle Inlay" } }

if lvim.builtin.noice.active then
    lvim.keys.insert_mode["<C-s>"] = function()
        local params = vim.lsp.util.make_position_params(0, "utf-16")
        vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(err, result, ctx)
            require("noice.lsp").signature(err, result, ctx, {
                trigger = true,
            })
        end)
    end
else
    lvim.keys.insert_mode["<C-s>"] = "<cmd>lua vim.lsp.buf.signature_help()<cr>"
end

lvim.builtin.which_key.mappings["a"] = {
    name = "ChatGPT",
    c = { "<cmd>ChatGPT<cr>", "Chat" },
    a = { "<cmd>ChatGPTActAs<cr>", "Act As" },
    e = { "<cmd>ChatGPTEditWithInstructions<cr>", "Edit with instructions", mode = "v" },
    s = { "<cmd>ChatRunCustomCodeAction<cr>", "Custome Code Action" },
    r = { "<cmd>lua require('user.telescope').chatgpt_run()<cr>)", "Chat Run", mode = "v" },
}

lvim.builtin.which_key.mappings["gY"] = {
    '<cmd>lua require"gitlinker".get_repo_url()<cr>',
    "Copy HomePage",
}

lvim.builtin.which_key.mappings["gB"] = {
    '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    "Open HomePage in Browser",
}
