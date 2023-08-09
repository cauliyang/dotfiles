vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "typst_lsp" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("typst_lsp", {
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    settings = {
        exportPdf = "onType",
    },
})
