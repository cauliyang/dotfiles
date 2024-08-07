local M = {}

M.config = function()
    local status_ok, refactoring = pcall(require, "refactoring")
    if not status_ok then
        return
    end

    refactoring.setup({
        -- prompt for return type
        prompt_func_return_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
            rust = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
            go = true,
            cpp = true,
            c = true,
            java = true,
            python = true,
            rust = true,
        },
    })
end

return M
