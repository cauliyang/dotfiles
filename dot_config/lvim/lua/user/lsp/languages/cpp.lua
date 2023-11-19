-- set formater
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
    { command = "clang-format", filetypes = { "c", "cpp" } },
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

local clangd_flags = {
    "--fallback-style=Google",
    "--background-index",
    "-j=8",
    "--all-scopes-completion",
    "--pch-storage=memory",
    "--clang-tidy",
    "--log=error",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
    "--offset-encoding=utf-16", --temporary fix for null-ls
    "--ranking-model=heuristics",
    "--function-arg-placeholders",
}

local provider = "clangd"

local custom_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
end

local status_ok, project_config = pcall(require, "rhel.clangd_wrl")
if status_ok then
    clangd_flags = vim.tbl_deep_extend("keep", project_config, clangd_flags)
end

local custom_on_init = function(client, bufnr)
    require("lvim.lsp").common_on_init(client, bufnr)
    require("clangd_extensions.config").setup({})
    -- require("clangd_extensions.ast").init()
    vim.cmd([[
  command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
  ]])
end

local opts = {
    cmd = { provider, unpack(clangd_flags) },
    on_attach = custom_on_attach,
    on_init = custom_on_init,
}

require("lvim.lsp.manager").setup("clangd", opts)

-- ref: https://github.com/Civitasv/cmake-tools.nvim/
local status_ok_2, cmake_tools = pcall(require, "cmake-tools")
if not status_ok_2 then
    return
end

cmake_tools.setup({
    cmake_command = "cmake",
    cmake_build_directory = "build",
    cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
    cmake_build_options = {},
    cmake_console_size = 10, -- cmake output window height
    cmake_show_console = "always", -- "always", "only_on_error"
    cmake_dap_configuration = { name = "cpp", type = "codelldb", request = "launch" }, -- dap configuration, optional
    cmake_dap_open_command = require("dap").repl.open, -- optional
    cmake_variants_message = {
        short = { show = true },
        long = { show = true, max_length = 40 },
    },
})
