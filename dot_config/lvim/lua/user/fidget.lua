local M = {}

M.config = function()
    local status_ok, fidget = pcall(require, "fidget")
    if not status_ok then
        return
    end

    local opts = {
        progress = {
            suppress_on_insert = true,
            ignore_done_already = true, -- Ignore new tasks that are already complete
            ignore_empty_message = true, -- Ignore new tasks that don't contain a message
            display = {
                render_limit = 8,
            },
        },
        -- Options related to notification subsystem
        notification = {
            -- Options related to the notification window and buffer
            window = {
                normal_hl = "Comment", -- Base highlight group in the notification window
                winblend = 100, -- Background color opacity in the notification window
                border = "none", -- Border around the notification window
                zindex = 45, -- Stacking priority of the notification window
                max_width = 0, -- Maximum width of the notification window
                max_height = 0, -- Maximum height of the notification window
                x_padding = 1, -- Padding from right edge of window boundary
                y_padding = 0, -- Padding from bottom edge of window boundary
                align = "bottom", -- How to align the notification window
                relative = "editor", -- What the notification window position is relative to
            },
        },
    }
    fidget.setup(opts)
end

return M
