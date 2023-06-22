local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    C = {
        name = "Cpp",
        H = {
            "<Cmd>ClangdSwitchSourceHeader<CR>",
            "Swich Header/Source",
        },
        g = { "<cmd>CMakeGenerate<CR>", "Generate CMake" },
        r = { "<cmd>CMakeRun<CR>", "Run CMake" },
        b = { "<cmd>CMakeBuild<CR>", "Build CMake" },
        d = { "<cmd>CMakeDebug<CR>", "Debug CMake" },
        sb = { "<cmd>CMakeSelectBuildType<CR>", "Select Build Type" },
        sB = { "<cmd>CMakeSelectBuildTarget<CR>", "Select Build Target" },
        st = { "<cmd>CMakeSelectLaunchTarget<CR>", "Select Launch Target" },
        o = { "<cmd>CMakeOpen<CR>", "Open CMake Console" },
        C = { "<cmd>CMakeClose<CR>", "Close CMake Console" },
        i = { "cmd>CMakeInstall<cr>", "Install CMake Targets" },
        c = { "<cmd>CMakeClean<CR>", "Clean CMake Targets" },
        s = { "<cmd>CMakeStop<CR>", "Stop CMake" },

        -- clangdextension
        em = { "<cmd>ClangdMemoryUsage<CR>", "ClangdMemoryUsae" },
        ea = { "<cmd>ClangdAST<CR>", "ClangdAST" },
        es = { "<cmd>ClangdsymbolInfo<CR>", "ClangdSymbolInfo" },
        et = { "<cmd>ClangdTypeHierarchy<CR>", "ClangdTypeHierarchy" },
    },
}

which_key.register(mappings, opts)
