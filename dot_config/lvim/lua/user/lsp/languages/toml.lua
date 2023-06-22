local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup({
    { command = "taplo", extra_args = { "fmt" }, filetypes = { "toml" } },
})

vim.filetype.add({
    extension = {
        toml = "toml",
    },
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "taplo" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("taplo", {
    filetypes = { "toml" },
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    single_file_support = true,
})
