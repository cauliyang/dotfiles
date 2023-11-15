vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "r_language_server" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("r_language_server", {
    cmd = { "R", "--slave", "-e", "languageserver::run()" },
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
})
