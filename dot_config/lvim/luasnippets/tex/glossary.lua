local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Math context detection
local tex = {}
tex.in_mathzone = function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
    return not tex.in_mathzone()
end

return {

    s(
        { trig = "ng" },
        fmta(
            [[
            \newglossaryentry{<>}
            {
                name=<>,
                description={<>}

            }
        ]],
            {
                i(1, "label"),
                i(2, "name"),
                i(3, "description"),
            }
        )
    ),

    s(
        { trig = "na" },
        fmta(
            [[
        \newacronym{<>}{<>}{<>}
        ]],
            {
                i(1, "label"),
                i(2, "short name"),
                i(3, "full name"),
            }
        )
    ),

    s(
        { trig = "acrs", snippetType = "autosnippet" },
        fmta([[ \acrshort{<>} ]], {
            d(1, get_visual),
        })
    ),

    s(
        { trig = "acrf", snippetType = "autosnippet" },
        fmta([[ \acrfull{<>} ]], {
            d(1, get_visual),
        })
    ),
    s(
        { trig = "gls", snippetType = "autosnippet" },
        fmta([[ \gls{<>}]], {
            d(1, get_visual),
        })
    ),
}
