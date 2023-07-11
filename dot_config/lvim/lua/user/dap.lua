local M = {}

local status_ok, dap = pcall(require, "dap")
if not status_ok then
    return
end

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

local function sep_os_replacer(str)
    local result = str
    local path_sep = package.config:sub(1, 1)
    result = result:gsub("/", path_sep)
    return result
end
local join_path = require("lvim.utils").join_paths

function M.lua()
    dap.configurations.lua = {
        {
            type = "nlua",
            request = "attach",
            name = "Neovim attach",
            host = function()
                local value = vim.fn.input("Host [127.0.0.1]: ")
                if value ~= "" then
                    return value
                end
                return "127.0.0.1"
            end,
            port = function()
                local val = tonumber(vim.fn.input("Port: "))
                assert(val, "Please provide a port number")
                return val
            end,
        },
    }
    dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
    end
end

function M.cpp()
    local path = vim.fn.glob(mason_path .. "packages/codelldb/extension/")
    local lldb_cmd = path .. "adapter/codelldb"

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            -- CHANGE THIS to your path!
            command = lldb_cmd,
            args = { "--port", "${port}" },

            -- On windows you may have to uncomment this:
            -- detached = false,
        },
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
            runInTerminal = true,
        },
    }

    dap.configurations.c = dap.configurations.cpp
end

function M.config()
    M.lua()
    M.cpp()
end

return M
