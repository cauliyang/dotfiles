local M = {}
-- https://github.com/lervag/vimtex/blob/master/autoload/vimtex.vim#L121
-- https://github.com/Uzaaft/lvim-abz/blob/main/lua/user/tex.lua

M.config = function()
    vim.g.maplocalleader = "\\"
    vim.g.vimtex_imaps_enabled = 1
    vim.g.vimtex_view_method = "skim"
    -- vim.g.vimtex_callback_progpath = "/Users/ylk4626/.local/bin/lvim"

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

    vim.g.vimtex_quickfix_open_on_warning = 0

    vim.g.vimtex_compiler_method = "latexmk"

    vim.g.vimtex_compiler_tectonic = {
        options = {
            "--keep-logs",
            "--synctex",
            "-Z search-path=/usr/local/texlive/2024/texmf-dist/tex/latex/biblatex",
            "-Z shell-escape",
        },
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
