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

M.python = function()
    local conda_python = os.getenv("CONDA_PREFIX") .. "/bin/python"
    require("dap-python").setup(conda_python)

    dap.configurations.python = dap.configurations.python or {}
    table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "launch with options",
        program = "${file}",
        python = function() end,
        pythonPath = function()
            local path
            for _, server in pairs(vim.lsp.buf_get_clients()) do
                if server.name == "pyright" or server.name == "pylance" then
                    path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
                    break
                end
            end
            path = vim.fn.input("Python path: ", path or "", "file")
            return path ~= "" and vim.fn.expand(path) or nil
        end,

        args = function()
            local args = {}
            local i = 1
            while true do
                local arg = vim.fn.input("Argument [" .. i .. "]: ")
                if arg == "" then
                    break
                end
                args[i] = arg
                i = i + 1
            end
            return args
        end,
        justMyCode = function()
            local yn = vim.fn.input("justMyCode? [y/n]: ")
            if yn == "y" then
                return true
            end
            return false
        end,
        stopOnEntry = function()
            local yn = vim.fn.input("stopOnEntry? [y/n]: ")
            if yn == "y" then
                return true
            end
            return false
        end,
        console = "integratedTerminal",
    })
end

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
    M.python()
    M.cpp()
end

return M
