local M = {}

M.config = function()
    require("lsp_lines").setup()

    vim.diagnostic.config({
        virtual_text = false,
    })

    vim.api.nvim_create_user_command("ToggleLSPLines", function()
        require("lsp_lines").toggle()
    end, {})
end

return M
