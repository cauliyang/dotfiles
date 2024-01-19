-- https://gist.github.com/lbiaggi/a3eb761ac2fdbff774b29c88844355b8

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    { command = "prettier", filetypes = { "markdown", "yaml", "css", "json" } },
})

local linter = require("lvim.lsp.null-ls.linters")
linter.setup({
    -- { command = "write-good", filetypes = { "markdown", "tex" } },
    -- https://github.com/errata-ai/vale
    { command = "vale", filetypes = { "markdown", "tex" } },
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "ltex", "marksman" })

require("lspconfig").ltex.setup({
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    on_attach = function(client, bufnr)
        -- your other on_attach functions.
        require("ltex_extra").setup({
            load_langs = { "en-us" }, -- table <string> : languages for witch dictionaries will be loaded
            init_check = true, -- boolean : whether to load dictionaries on startup
            path = ".ltex", -- string : path to store dictionaries. Relative path uses current working directory
            log_level = "error", -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
        })
    end,
    settings = {
        ltex = {
            additionalrules = {
                enablepickyrules = true,
                mothertongue = "en-us",
            },

            checkFrequency = "edit",
            diagnosticSeverity = "information",
        },
    },
})

require("lspconfig").marksman.setup({})
