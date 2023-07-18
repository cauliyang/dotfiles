vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "html" })

require("lspconfig").html.setup({

    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),

    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
})
