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

vim.diagnostic.config({
    virtual_text = false,
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    { command = "google_java_format", filetypes = { "java" } },
    { command = "stylua", filetypes = { "lua" } },
    { command = "shfmt", filetypes = { "sh", "zsh" } },
})
