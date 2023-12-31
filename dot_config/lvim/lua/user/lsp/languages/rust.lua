vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local codelldb_adapter = {
    type = "server",
    port = "${port}",
    executable = {
        command = mason_path .. "bin/codelldb",
        args = { "--port", "${port}" },
    },
}

-- HACK: fix milti client offset_encoding erros  with copoilt <Yangyang Li>

--- Generates the LSP client capabilities
--- @return table
local function rdefault_capabilities()
    -- Client capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Setup capabilities for nvim-cmp
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    --- Setup capabilities to support utf-16, since copilot.lua only works with utf-16
    --- this is a workaround to the limitations of copilot language server
    capabilities = vim.tbl_deep_extend("force", capabilities, {
        offsetEncoding = { "utf-16" },
        general = {
            positionEncodings = { "utf-16" },
        },
    })

    return capabilities
end

vim.g.rustaceanvim = {
    tools = {
        reload_workspace_from_cargo_toml = true,

        runnables = {
            use_telescope = true,
        },

        hover_actions = {
            auto_focus = true,
        },

        crate_graph = {
            backend = "pdf",
            output = "crate_graph.pdf",
        },

        on_initialized = function()
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                pattern = { "*.rs" },
                callback = function()
                    local _, _ = pcall(vim.lsp.codelens.refresh)
                end,
            })
        end,
    },

    dap = {
        adapter = codelldb_adapter,
    },

    server = {
        on_attach = require("lvim.lsp").common_on_attach,
        -- capabilities = require("lvim.lsp").common_capabilities(),
        capabilities = rdefault_capabilities(),
        offset_encoding = "utf-16",

        settings = {
            ["rust-analyzer"] = {
                inlayHints = {
                    locationLinks = true,
                },
                lens = {
                    enable = true,
                },
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                },
                diagnostics = {
                    experimental = true,
                },
                procMacro = {
                    enable = true,
                },
                cargo = {
                    allFeatures = false,
                },
            },
        },
    },
}

-- -- CHANGED --
local dap = require("dap")
dap.adapters.codeleldb = codeleldb_adapter
dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        args = function()
            local args = {}
            local i = 1
            while true do
                local arg = vim.fn.input("Argument [" .. i .. "]: ")
                if arg == "" then
                    break
                end
                args[i] = arg
                i = i + 1
            end
            return args
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}
