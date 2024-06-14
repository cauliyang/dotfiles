local M = {}

M.config = function()
    require("trouble").setup({
        focus = true,
        preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.4, height = 0.3 },
            zindex = 200,
        },
    })
end

return M
