local M = {}

M.config = function()
    -- local status_ok, silicon = pcall(require, "silicon")
    -- if not status_ok then
    --     return
    -- end

    require("silicon").setup({
        -- The following keys are all optional
        -- with default values
        -- The following key is required if you want to save image to file instead of clipboard
        output = {
            file = "", -- full path of the file to save to.
            clipboard = false,
            path = "~/Downloads/vim-screenshot", -- where to save images e.g. /home/user/Pictures
            format = "silicon_[year][month][day]_[hour][minute][second].png",
        },

        font = "Hack=20",
        theme = "Dracula",
        background = "#eff",
        shadow = {
            blur_radius = 0.0,
            offset_x = 0,
            offset_y = 0,
            color = "#555",
        },

        pad_horiz = 100,
        pad_vert = 80,
        line_number = false,
        line_pad = 2,
        line_offset = 1,
        tab_width = 4,
        round_corner = true,
        window_controls = true,
        watermark = {
            text = "@yangyangli", -- add this to enable watermark on the bottom-right.
            color = "#222",
            style = "bold", -- possible values: 'bold' | 'italic' | 'bolditalic' | anything else defaults to 'regular'.
        },
    })
end

return M
