local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

local function env(name)
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

local function in_math()
    return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

local in_text = function()
    return not in_math()
end

local function in_bullets()
    return env("itemize") or env("enumerate")
end

local make_condition = require("luasnip.extras.conditions").make_condition
local in_bullets_cond = make_condition(in_bullets)
local line_begin = require("luasnip.extras.conditions.expand").line_begin

-- Generating functions for Matrix/Cases - thanks L3MON4D3!
local generate_matrix = function(args, snip)
    local rows = tonumber(snip.captures[2])
    local cols = tonumber(snip.captures[3])
    local nodes = {}
    local ins_indx = 1
    for j = 1, rows do
        table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(" & "))
            table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ "\\\\", "" }))
    end
    -- fix last node.
    nodes[#nodes] = t("\\\\")
    return sn(nil, nodes)
end

-- update for cases
local generate_cases = function(args, snip)
    local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
    local cols = 2 -- fix to 2 cols
    local nodes = {}
    local ins_indx = 1
    for j = 1, rows do
        table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
        ins_indx = ins_indx + 1
        for k = 2, cols do
            table.insert(nodes, t(" & "))
            table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
            ins_indx = ins_indx + 1
        end
        table.insert(nodes, t({ "\\\\", "" }))
    end
    -- fix last node.
    table.remove(nodes, #nodes)
    return sn(nil, nodes)
end

local reference_snippet_table = {
    a = "auto",
    c = "c",
    C = "C",
    e = "eq",
    r = "",
}

return {
    s(
        {
            trig = " ([acCer])ref",
            name = "(acC|eq)?ref",
            dscr = "add a reference (with autoref, cref, eqref)",
            trigEngine = "pattern",
            hidden = true,
            snippetType = "autosnippet",
            wordTrig = false,
        },
        fmta(
            [[
    ~\<>ref{<>:<>}<>
    ]],
            {
                f(function(_, snip)
                    return reference_snippet_table[snip.captures[1]]
                end),
                i(1),
                i(2),
                i(0),
            }
        ),
        { condition = in_text, show_condition = in_text }
    ),

    s(
        { trig = "enquote", snippetType = "autosnippet" },
        fmta([[~\enquote{<>} ]], {
            d(1, get_visual),
        })
    ),

    s(
        { trig = " CI", snippetType = "autosnippet", wordTrig = false },
        fmta(
            [[
      ~\cite{<>}
      ]],
            {
                d(1, get_visual),
            }
        )
    ),

    s(
        { trig = "--", hidden = true, snippetType = "autosnippet" },
        { t("\\item") },
        { condition = in_bullets_cond * line_begin, show_condition = in_bullets_cond * line_begin }
    ),

    s(
        { trig = "!-", name = "bullet point", dscr = "bullet point with custom text", snippetType = "autosnippet" },
        fmta(
            [[ 
    \item [<>]<>
    ]],
            { i(1), i(0) }
        ),
        { condition = in_bullets_cond * line_begin, show_condition = in_bullets_cond * line_begin }
    ),

    -- Matrices and Cases
    s(
        {
            trig = "([bBpvV])ma (%d+)x (%d+)([ar])",
            name = "[bBpvV]matrix",
            dscr = "matrices",
            regTrig = true,
            hidden = true,
            snippetType = "autosnippet",
        },
        fmta(
            [[
    \begin{<>}<>
    <>
    \end{<>}]],
            {
                f(function(_, snip)
                    return snip.captures[1] .. "matrix"
                end),
                f(function(_, snip)
                    if snip.captures[4] == "a" then
                        out = string.rep("c", tonumber(snip.captures[3]) - 1)
                        return "[" .. out .. "|c]"
                    end
                    return ""
                end),
                d(1, generate_matrix),
                f(function(_, snip)
                    return snip.captures[1] .. "matrix"
                end),
            }
        ),
        { condition = in_math, show_condition = in_math }
    ),

    s(
        {
            trig = "(%d?)cases",
            name = "cases",
            dscr = "cases",
            regTrig = true,
            hidden = true,
            snippetType = "autosnippet",
        },
        fmta(
            [[
    \begin{cases}
    <>
    .\end{cases}
    ]],
            { d(1, generate_cases) }
        ),
        { condition = in_math, show_condition = in_math }
    ),
}
