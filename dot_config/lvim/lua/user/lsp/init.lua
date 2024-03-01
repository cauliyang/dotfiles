require("user.lsp.languages.rust")
require("user.lsp.languages.python")
require("user.lsp.languages.sh")
require("user.lsp.languages.toml")
require("user.lsp.languages.cpp")
require("user.lsp.languages.markdown")
require("user.lsp.languages.latex")
require("user.lsp.languages.bib")
require("user.lsp.languages.html")
require("user.lsp.languages.r")
require("user.lsp.languages.lua")
require("user.lsp.languages.dockerfile")
require("user.lsp.languages.typst")
require("user.lsp.languages.javascript")

local icons = require("user.icons").icons

local default_diagnostic_config = {
    signs = {
        active = true,
        text = {
            [vim.diagnostic.severity.ERROR] = icons.error,
            [vim.diagnostic.severity.WARN] = icons.warn,
            [vim.diagnostic.severity.INFO] = icons.info,
            [vim.diagnostic.severity.HINT] = icons.hint,
        },
        values = {
            { name = "DiagnosticSignError", text = icons.error },
            { name = "DiagnosticSignWarn", text = icons.warn },
            { name = "DiagnosticSignInfo", text = icons.info },
            { name = "DiagnosticSignHint", text = icons.hint },
        },
    },
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        source = "if_many",
        header = "",
        prefix = "",
        border = {
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
            { " ", "FloatBorder" },
        },
    },
}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

lvim.lsp.document_highlight = true
lvim.lsp.code_lens_refresh = true

-- LSP lines
vim.diagnostic.config({ virtual_lines = false, update_in_insert = true })

-- Setup diagnostics
if lvim.builtin.lsplines then
    default_diagnostic_config.virtual_text = false
end

vim.diagnostic.config(default_diagnostic_config)

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    { command = "google_java_format", filetypes = { "java" } },
    { command = "stylua", filetypes = { "lua" } },
    { command = "shfmt", filetypes = { "sh", "zsh" } },
})
