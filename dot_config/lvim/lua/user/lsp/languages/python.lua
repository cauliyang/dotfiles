local formatters = require("lvim.lsp.null-ls.formatters")
-- Set a formatter.
formatters.setup({
    { command = "black", filetypes = { "python" } },
})

-- Set a linter.
-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
--     {
--         command = "ruff",
--         filetypes = { "python" },
--     },
-- })

-- set lsp
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "ruff_lsp" })
local lsp_manager = require("lvim.lsp.manager")

lsp_manager.setup("pyright", {
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    settings = {
        pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
            },
        },
    },
    single_file_support = true,
    filetypes = { "python" },
})

local ruff_opts = {
    single_file_support = true,
    filetypes = { "python" },
}

lsp_manager.setup("ruff_lsp", ruff_opts)

-- -- Setup dap for python
-- local conda_python = os.getenv("CONDA_PREFIX") .. "/bin/python"
-- pcall(function()
--     require("dap-python").setup(conda_python)
-- end)

-- -- Supported test frameworks are unittest, pytest and django. By default it
-- -- tries to detect the runner by probing for pytest.ini and manage.py, if
-- -- neither are present it defaults to unittest.
-- pcall(function()
--     require("dap-python").test_runner = "pytest"
-- end)

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "python" },
    callback = function()
        lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
        lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" }
        lvim.builtin.which_key.vmappings["d"] = {
            name = "Debug",
            s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
        }
    end,
})
