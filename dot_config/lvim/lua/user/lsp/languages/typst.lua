vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "typst_lsp" })

-- require("lspconfig").typst_lsp.setup({
--     settings = {
--         exportPdf = "onType", -- Choose onType, onSave or never.
--         -- serverPath = "" -- Normally, there is no need to uncomment it.
--     },
-- })

-- vim.filetype.add({ extension = { typ = "typst" } })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("typst_lsp", {
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    settings = {
        exportPdf = "onType",
    },
})
