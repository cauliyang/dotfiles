local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    { command = "latexindent", filetypes = { "tex" } },
})

--  reference : https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/texlab.lua
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "texlab" })

local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("texlab", {
    on_init = require("lvim.lsp").common_on_init,
    capabilities = require("lvim.lsp").common_capabilities(),
    config = {
        texlab = {
            rootDirectory = nil,
            build = {
                executable = "latexmk",
                args = {
                    "-pdf",
                    "-interaction=nonstopmode",
                    "-shell-escape", -- enable mint
                    "-synctex=1",
                    "%f",
                    "-output-directory=../build",
                },

                -- executable = "tectonic",
                -- args = {
                -- 	"-X",
                -- 	"compile",
                -- 	"%f",
                -- 	"--keep-logs",
                -- 	"--keep-intermediates",
                -- 	"--synctex",
                -- 	"--outdir",
                -- 	"../build",
                -- },

                onSave = false,
                forwardSearchAfter = false,
            },
            auxDirectory = "build",
            forwardSearch = {
                executable = nil,
                args = {},
            },
            chktex = {
                onOpenAndSave = true,
                onEdit = true,
            },
            diagnosticsDelay = 300,
            latexFormatter = "latexindent",
            latexindent = {
                ["local"] = nil, -- local is a reserved keyword
                modifyLineBreaks = false,
            },
            bibtexFormatter = "texlab",
            formatterLineLength = 80,
        },
    },
})
