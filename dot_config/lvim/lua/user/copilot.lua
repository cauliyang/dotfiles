local M = {}
local icons = require("user.icons").icons

M.enabled = function()
    if lvim.builtin.copilot.active then
        for idx, source in pairs(vim.lsp.get_active_clients()) do
            if source.name == "copilot" then
                return true
            end
        end
    end
    return false
end

return M
