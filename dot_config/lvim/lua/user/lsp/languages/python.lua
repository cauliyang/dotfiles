-- set lsp
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright", "ruff_lsp", "basedpyright" })
local lsp_manager = require("lvim.lsp.manager")

lsp_manager.setup("basedpyright", {
    on_init = require("lvim.lsp").common_on_init,
    on_attach = require("lvim.lsp").common_on_attach,
    capabilities = require("lvim.lsp").common_capabilities(),
    settings = {},
    single_file_support = true,
    filetypes = { "python" },
})

local ruff_opts = {
    single_file_support = true,
    filetypes = { "python" },
    format = { enable = true },
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
