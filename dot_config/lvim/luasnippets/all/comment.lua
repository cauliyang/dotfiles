local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
    return
end

local calculate_comment_string = require("Comment.ft").calculate
local utils = require("Comment.utils")

--- Get the comment string {beg,end} table
---@param ctype integer 1 for `line`-comment and 2 for `block`-comment
---@return table comment_strings {begcstring, endcstring}
local get_cstring = function(ctype)
    -- use the `Comments.nvim` API to fetch the comment string for the region (eq. '--%s' or '--[[%s]]' for `lua`)
    local cstring = calculate_comment_string({ ctype = ctype, range = utils.get_region() }) or vim.bo.commentstring
    -- as we want only the strings themselves and not strings ready for using `format` we want to split the left and right side
    local left, right = utils.unwrap_cstr(cstring)
    -- create a `{left, right}` table for it
    return { left, right }
end

_G.luasnip = {}
_G.luasnip.vars = {
    username = "Yangyang Li",
    email = "yangyang.li@northwestern.edu",
    github = "https://github.com/cauliyang",
    real_name = "Yangyang Li",
}

--- Options for marks to be used in a TODO comment
local marks = {
    signature = function()
        return fmt("<{}>", i(1, _G.luasnip.vars.username))
    end,
    signature_with_email = function()
        return fmt("<{}{}>", { i(1, _G.luasnip.vars.username), i(2, " " .. _G.luasnip.vars.email) })
    end,
    date_signature_with_email = function()
        return fmt(
            "<{}{}{}>",
            { i(1, os.date("%m-%d-%y")), i(2, ", " .. _G.luasnip.vars.username), i(3, " " .. _G.luasnip.vars.email) }
        )
    end,
    date_signature = function()
        return fmt("<{}{}>", { i(1, os.date("%m-%d-%y")), i(2, ", " .. _G.luasnip.vars.username) })
    end,
    date = function()
        return fmt("<{}>", i(1, os.date("%m-%d-%y")))
    end,

    -- empty = function()
    --     return t("")
    -- end,
}

local todo_snippet_nodes = function(aliases, opts)
    local aliases_nodes = vim.tbl_map(function(alias)
        return i(nil, alias) -- generate choices for [name-of-comment]
    end, aliases)
    local sigmark_nodes = {} -- choices for [comment-mark]
    for _, mark in pairs(marks) do
        table.insert(sigmark_nodes, mark())
    end
    -- format them into the actual snippet
    local comment_node = fmta("<> <>: <> <> <><>", {
        f(function()
            return get_cstring(opts.ctype)[1] -- get <comment-string[1]>
        end),
        c(1, aliases_nodes), -- [name-of-comment]
        i(3), -- {comment-text}
        c(2, sigmark_nodes), -- [comment-mark]
        f(function()
            return get_cstring(opts.ctype)[2] -- get <comment-string[2]>
        end),
        i(0),
    })
    return comment_node
end

--- Generate a TODO comment snippet with an automatic description and docstring
---@param context table merged with the generated context table `trig` must be specified
---@param aliases string[]|string of aliases for the todo comment (ex.: {FIX, ISSUE, FIXIT, BUG})
---@param opts table merged with the snippet opts table
local todo_snippet = function(context, aliases, opts)
    opts = opts or {}
    aliases = type(aliases) == "string" and { aliases } or aliases -- if we do not have aliases, be smart about the function parameters
    context = context or {}
    if not context.trig then
        return error("context doesn't include a `trig` key which is mandatory", 2) -- all we need from the context is the trigger
    end
    opts.ctype = opts.ctype or 1 -- comment type can be passed in the `opts` table, but if it is not, we have to ensure, it is defined
    local alias_string = table.concat(aliases, "|") -- `choice_node` documentation
    context.name = context.name or (alias_string .. " comment") -- generate the `name` of the snippet if not defined
    context.dscr = context.dscr or (alias_string .. " comment with a signature-mark") -- generate the `dscr` if not defined
    context.docstring = context.docstring or (" {1:" .. alias_string .. "}: {3} <{2:mark}>{0} ") -- generate the `docstring` if not defined
    local comment_node = todo_snippet_nodes(aliases, opts) -- nodes from the previously defined function for their generation
    return s(context, comment_node, opts) -- the final todo-snippet constructed from our parameters
end

local todo_snippet_specs = {
    { { trig = "todo" }, "TODO" },
    { { trig = "fix" }, { "FIX", "BUG", "ISSUE", "FIXIT" } },
    { { trig = "hack" }, "HACK" },
    { { trig = "warn" }, { "WARN", "WARNING", "XXX" } },
    { { trig = "perf" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
    { { trig = "note" }, { "NOTE", "INFO" } },
    -- NOTE: Block commented todo-comments <kunzaatko>
    { { trig = "todob" }, "TODO", { ctype = 2 } },
    { { trig = "fixb" }, { "FIX", "BUG", "ISSUE", "FIXIT" }, { ctype = 2 } },
    { { trig = "hackb" }, "HACK", { ctype = 2 } },
    { { trig = "warnb" }, { "WARN", "WARNING", "XXX" }, { ctype = 2 } },
    { { trig = "perfb" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" }, { ctype = 2 } },
    { { trig = "noteb" }, { "NOTE", "INFO" }, { ctype = 2 } },
}

local todo_comment_snippets = {}

for _, v in ipairs(todo_snippet_specs) do
    -- NOTE: 3rd argument accepts nil
    table.insert(todo_comment_snippets, todo_snippet(v[1], v[2], v[3]))
end

-- NOTE: Add box comment <13-01-23, Yangyang Li>
local function create_box(opts)
    local pl = opts.padding_length or 4
    local function pick_comment_start_and_end()
        -- because lua block comment is unlike other language's,
        --  so handle lua ctype
        local ctype = 2
        if vim.opt.ft:get() == "lua" then
            ctype = 1
        end
        local cs = get_cstring(ctype)[1]
        local ce = get_cstring(ctype)[2]
        if ce == "" or ce == nil then
            ce = cs
        end
        return cs, ce
    end
    return {
        -- top line
        f(function(args)
            local cs, ce = pick_comment_start_and_end()
            return cs .. string.rep(string.sub(cs, #cs, #cs), string.len(args[1][1]) + 2 * pl) .. ce
        end, { 1 }),
        t({ "", "" }),
        f(function()
            local cs = pick_comment_start_and_end()
            return cs .. string.rep(" ", pl)
        end),
        i(1, "box"),
        f(function()
            local cs, ce = pick_comment_start_and_end()
            return string.rep(" ", pl) .. ce
        end),
        t({ "", "" }),
        -- bottom line
        f(function(args)
            local cs, ce = pick_comment_start_and_end()
            return cs .. string.rep(string.sub(ce, 1, 1), string.len(args[1][1]) + 2 * pl) .. ce
        end, { 1 }),
    }
end

local box_comment = {
    s({ trig = "box" }, create_box({ padding_length = 8 })),
    s({ trig = "bbox" }, create_box({ padding_length = 20 })),
}

-- merge(snippets, todo_comment_snippets)
for _, v in ipairs(box_comment) do
    table.insert(todo_comment_snippets, v)
end

return todo_comment_snippets
