local M = {}
-- https://github.com/lervag/vimtex/blob/master/autoload/vimtex.vim#L121
-- https://github.com/Uzaaft/lvim-abz/blob/main/lua/user/tex.lua

M.config = function()
    vim.g.maplocalleader = "\\"
    vim.g.vimtex_imaps_enabled = 0
    -- vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_view_method = "skim"
    -- vim.g.vimtex_view_method = "sioyek"
    -- vim.g.vimtex_compiler_latexmk_engines = "-lualatex"
    -- " Disable some compilation warning messages
    vim.g.vimtex_quickfix_ignore_filters = {
        "LaTeX hooks Warning",
        "Underfull \\hbox",
        "Overfull \\hbox",
        "W Overfull \\hbox",
        "LaTeX Warning: .+ float specifier changed to",
        'Package siunitx Warning: Detected the "physics" package:',
        "Package hyperref Warning: Token not allowed in a PDF string",
        "Fatal error occurred, no output PDF file produced!",
    }

    vim.g.vimtex_compiler_latexmk = {
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
            "-shell-escape",
            "-verbose",
            "-file-line-error",
            "--synctex=1",
            "-interaction=nonstopmode",
        },
    }

    vim.cmd([[ 
            inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
            nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
        ]])

    vim.api.nvim_create_user_command("TexToggleShellEscape", function()
        -- lua is 1-indexed
        if vim.g.vimtex_compiler_latexmk.options[1] == "-shell-escape" then
            print("disable shell escape")
            vim.cmd("call remove(g:vimtex_compiler_latexmk.options, 0)")
        else
            print("enable shell escape")
            vim.cmd("call insert(g:vimtex_compiler_latexmk.options, '-shell-escape', 0)")
        end
        vim.cmd("VimtexReload")
        vim.cmd("VimtexClean")
    end, {})
end

return M
