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
        a = { "<cmd>lua require('rust-tools').hove_actions.hover_actions()<cr>", "Hover Actions" },
        A = { "<cmd>lua require('rust-tools').code_action_group.code_action_group()<cr>", "Code Action Group" },
        r = { "<cmd>lua require('rust-tools').runnables.runnables()<cr>", "Runnables" },
        R = { "<cmd>lua require('rust-tools').debuggables.debuggables()<cr>", "Debuggables" },
        e = { "<cmd>lua require('rust-tools').expand_macro.expand_macro()<cr>", "Expand Macro" },
        m = { "<cmd>lua require('rust-tools').parent_module.parent_module()<cr>", "Parent Module" },
        u = { "<cmd>lua require('rust-tools').move_item.move_item(true)<cr>", "Move Item Up" },
        d = { "<cmd>lua require('rust-tools').move_item.move_item(false)<cr>", "Move Item Down" },
        H = { "<cmd>lua require('rust-tools').hover_range.hover_range()<cr>", "Hover Range" },
        c = { "<cmd>lua require('rust-tools').open_cargo_toml.open_cargo_toml()<cr>", "Open Cargo.toml" },
        j = { "<cmd>lua require('rust-tools').join_lines.join_lines()<cr>", "Join Lines" },

        D = { "<cmd>RustOpenExternalDocs<Cr>", "Open Docs" },

        -- D = { "<Cmd>lua require('crates').open_documentation()<CR>", "Open Documentation" },

        v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },

        L = {
            "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
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
