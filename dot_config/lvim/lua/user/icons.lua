local M = {}

M.icons = {
    error = "󰅚 ",
    warn = " ",
    info = " ",
    hint = "󰌶 ",
    debug = " ",
    trace = "✎",
    code_action = "",
    code_lens_action = "󰄄 ",
    test = " ",
    docs = " ",
    clock = "󰋚 ",
    calendar = " ",
    buffer = "󰀿 ",
    settings = " ",
    ls_inactive_old = "󰒎 ",
    ls_active_old = "󰒍 ",
    ls_active = "󰕮 ",
    ls_inactive = "",
    question = " ",
    added = "  ",
    modified = "󰝤 ",
    removed = " ",
    screen = "󰐯",
    dart = " ",
    config = " ",
    git = "",
    magic = " ",
    exit = "󰅚 ",
    exit2 = "󰅙 ",
    session = "󰄉 ",
    project = " ",
    Package = " ",
    stuka = " ",
    text = "󰊄",
    files = " ",
    zoxide = "Z",
    repo = "",
    term = " ",
    palette = " ",
    buffers = "󰕰",
    telescope = "",
    dashboard = "󰕮",
    boat = " ",
    unmute = "",
    mute = "",
    quit = "󰗼",
    replace = "",
    find = "",
    comment = "󰍪",
    ok = "",
    no = "",
    moon = "",
    go = "",
    resume = " ",
    codelens = "󰄄 ",
    folder = "",
    package = "󰏗",
    spelling = " ",
    copilot = " ",
    attention = "",
    Function = "",
    zen = "",
    music = "",
    nuclear = "☢",
    grammar = "󰓆",
    treesitter = "",
    lock = "",
    presence_on = "󰅠",
    presence_off = "󰅣",
    right = " ",
    caret = "-",
    flash = " ",
    world = " ",
    label = " ",
    person = "",
    expanded = "",
    collapsed = "",
    circular = "",
    circle_left = "",
    circle_right = "",
    neotest = "󰙨",
    rename = " ",
    amazon = " ",
    inlay = " ",
    pinned = " ",
}

M.todo_comments = {
    FIX = "󰓙",
    TODO = " ",
    HACK = "󰂖 ",
    WARN = "󰒡",
    PERF = "󰓅",
    NOTE = "󰍪 ",
    ERROR = " ",
    REFS = "",
    SHIELD = "",
}

M.file_icons = {
    Brown = { "" },
    Aqua = { "" },
    LightBlue = { "", "" },
    Blue = { "", "", "", "", "", "", "", "", "", "", "", "", "" },
    Darkblue = { "", "" },
    Purple = { "", "", "", "", "" },
    Red = { "", "", "", "", "", "" },
    Beige = { "", "", "" },
    Yellow = { "", "", "λ", "", "" },
    Orange = { "", "" },
    Darkorange = { "", "", "", "", "" },
    Pink = { "", "" },
    Salmon = { "" },
    Green = { "", "", "", "", "", "󰌛" },
    Lightgreen = { "", "", "", "󰡄" },
    White = { "", "", "", "", "", "" },
}

M.nvimtree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "",
        unmerged = "",
        renamed = "➜",
        untracked = "",
        deleted = "",
        ignored = "◌",
    },
    folder = {
        arrow_closed = "",
        arrow_open = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
}

if lvim.builtin.tree_provider == "neo-tree" then
    M.nvintree_icons["git"] = {
        unmerged = "",
        added = "",
        deleted = "",
        modified = "",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
    }
end

M.define_dap_signs = function()
    vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
    vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
    vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
        "DapLogPoint",
        { text = "󰍩", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
    )
end

M.mason = {
    package_pending = " ",
    package_installed = "󰄳 ",
    package_uninstalled = " ",
}

M.set_icon = function()
    require("nvim-web-devicons").set_icon({
        toml = {
            icon = "📦",
            color = "#8FAA54",
            name = "Toml",
        },
        rs = {
            icon = "🦀",
            color = "#d28445",
            name = "Rust",
        },
        tf = {
            icon = "",
            color = "#3d59a1",
            name = "Terraform",
        },
        tfvars = {
            icon = "",
            color = "#51afef",
            name = "Terraform",
        },
        mod = {
            icon = "",
            color = "#6a9fb5",
            name = "Mod",
        },
        sum = {
            icon = "",
            color = "#6a9fb5",
            name = "Sum",
        },
        txt = {
            icon = "",
            color = "#bbc2cf",
            name = "Text",
        },
        csv = {
            icon = " ",
            color = "#31B53E",
            name = "CSV",
        },
        plist = {
            icon = "",
            color = "#8FAA54",
            name = "Plist",
        },
        burp = {
            icon = "",
            color = "#F16529",
            name = "Burp",
        },
        mp4 = {
            icon = "",
            color = "#5fd7ff",
            name = "MP4",
        },
        mkv = {
            icon = "",
            color = "#5fd7ff",
            name = "MKV",
        },
        hcl = {
            icon = "",
            color = "#689FB6",
            name = "HCL",
        },
        sol = {
            icon = "",
            color = "#555555",
            name = "Sol",
        },
    })
end

return M
