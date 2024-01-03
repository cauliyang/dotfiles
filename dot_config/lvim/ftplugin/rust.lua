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
        a = { "<cmd>lua vim.cmd.RustLsp {'hover', 'actions'}<cr>", "Hover Actions" },
        L = { "<cmd>RustLsp  reloadWorkspace<cr>", "Reload Workspace" },
        r = { "<cmd>lua vim.cmd.RustLsp {'runnables', 'last'}<cr>", "Runnables" },
        R = { "<cmd>lua vim.cmd.RustLsp {'debuggables', 'last' }<cr>", "Debuggables" },
        e = { "<cmd>lua vim.cmd.RustLsp('expandMacro')<cr>", "Expand Macro" },
        m = { "<cmd>lua vim.cmd.RustLsp('parentModule')<cr>", "Parent Module" },
        u = { "<cmd>lua vim.cmd.RustLsp { 'moveItem',  'up' }<cr>", "Move Item Up" },
        d = { "<cmd>lua vim.cmd.RustLsp { 'moveItem',  'down' }<cr>", "Move Item Down" },
        h = { "<cmd>RustLsp view hir<cr>", "Viw HIR|MIR" },
        H = { "<cmd>lua vim.cmd.RustLsp { 'hover', 'range' }<cr>", "Hover Range" },
        c = { "<cmd>lua vim.cmd.RustLsp('openCargo')<cr>", "Open Cargo.toml" },
        j = { "<cmd>lua vim.cmd.RustLsp('joinLines')<cr>", "Join Lines" },
        x = { "<cmd>lua vim.cmd.RustLsp('explainError')<cr>", "Explain Error" },
        s = { "<cmd>RustLsp ssr<cr>", "Structural Search Replace" },
        S = { "<cmd>RustLsp syntaxTree<cr>", "Syntax Tree" },

        D = { "<cmd>RustLsp externalDocs<cr>", "Open Docs" },

        v = { "<cmd>RustLsp crateGraph<cr>", "View Crate Graph" },

        lt = { "<cmd>lua require('crates').toggle()<cr>", "Toggle Crate" },
        lu = { "<cmd>lua require('crates').update_crate()<cr>", "Update Crate" },
        lU = { "<cmd>lua require('crates').upgrade_crate()<cr>", "Upgrade Crate" },
        lg = { "<cmd>lua require('crates').update_all_crates()<cr>", "Update All" },
        lG = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All" },
        lH = { "<cmd>lua require('crates').open_homepage()<cr>", "Open HomePage" },
    },
}

which_key.register(mappings, opts)

-- extract function

lvim.builtin.which_key.mappings["lx"] =
    { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Extract Function", mode = { "n", "v" } }
