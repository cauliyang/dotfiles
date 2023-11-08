local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    C = {
        name = "Rust",
        a = { "<cmd>lua vim.cmd.RustLsp { 'hover', 'actions' }<cr>", "Hover Actions" },
        A = { "<cmd>lua require('rust-tools').code_action_group.code_action_group()<cr>", "Code Action Group" },
        r = { "<cmd>lua vim.cmd.RustLsp {'runnables', 'last' --[[ optional ]] }<cr>", "Runnables" },
        R = { "<cmd>lua vim.cmd.RustLsp {'debuggables', 'last' --[[ optional ]] }<cr>", "Debuggables" },
        e = { "<cmd>lua vim.cmd.RustLsp('expandMacro')<cr>", "Expand Macro" },
        E = { "<cmd>lua vim.cmd.RustLsp('explainError')<cr>", "Explain Error" },
        m = { "<cmd>lua vim.cmd.RustLsp('parentModule')<cr>", "Parent Module" },
        u = { "<cmd>lua vim.cmd.RustLsp { 'moveItem',  'up' }<cr>", "Move Item Up" },
        d = { "<cmd>lua vim.cmd.RustLsp { 'moveItem',  'down' }<cr>", "Move Item Down" },
        H = { "<cmd>lua vim.cmd.RustLsp { 'hover', 'range' }<cr>", "Hover Range" },
        c = { "<cmd>lua vim.cmd.RustLsp('openCargo')<cr>", "Open Cargo.toml" },
        j = { "<cmd>lua vim.cmd.RustLsp('joinLines')<cr>", "Join Lines" },
        f = { "<cmd>lua vim.cmd.RustLsp('flyCheck')<cr>", "Fly Check" },

        D = { "<cmd>lua vim.cmd.RustLsp('externalDocs')<cr>", "Open Docs" },

        v = { "<cmd>vim.cmd.RustLsp { 'crateGraph', '[backend]', '[output]' }<Cr>", "View Crate Graph" },

        L = {
            "<cmd>lua vim.cmd.RustLsp('reloadWorkspace')<cr>",
            "Reload Workspace",
        },

        lt = { "<Cmd>lua require('crates').toggle()<CR>", "Toggle Crate" },
        lu = { "<Cmd>lua require('crates').update_crate()<CR>", "Update Crate" },
        lU = { "<Cmd>lua require('crates').upgrade_crate()<CR>", "Upgrade Crate" },
        lg = { "<Cmd>lua require('crates').update_all_crates()<CR>", "Update All" },
        lG = { "<Cmd>lua require('crates').upgrade_all_crates()<CR>", "Upgrade All" },
        lH = { "<Cmd>lua require('crates').open_homepage()<CR>", "Open HomePage" },
    },
}

which_key.register(mappings, opts)

-- extract function

lvim.builtin.which_key.mappings["lx"] =
    { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Extract Function", mode = { "n", "v" } }
