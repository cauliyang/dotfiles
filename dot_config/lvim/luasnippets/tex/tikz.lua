local tex_utils = {}

tex_utils.in_env = function(name) -- generic environment detection
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

tex_utils.in_tikz = function() -- TikZ picture environment detection
    return tex_utils.in_env("tikzpicture")
end

local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

return {

    s(
        { trig = "standalone" },
        fmta(
            [[
            \documentclass[tikz,border=10pt]{standalone}
            \usepackage{tkz-graph}
            \usepackage{amsmath,amssymb}
            \usepackage{xcolor}
            \usetikzlibrary{calc}
            \usetikzlibrary{positioning}

            \begin{document}
                <>
            \end{document}
            ]],
            {
                d(1, get_visual),
            }
        )
    ),

    s(
        { trig = "tfig" },
        fmta(
            [[
            \begin{figure}
                \centering
                \includestandalone[width=0.9\textwidth]{<>}
                \caption{<>}
                \label{fig:<>}
            \end{figure}
            ]],
            {
                i(1, "path"),
                i(2, "caption"),
                i(3, "label"),
            }
        )
    ),

    s(
        { trig = "tikz" },
        fmta(
            [[
            \begin{tikzpicture}
                <>
            \end{tikzpicture}
            ]],
            {
                i(1, ""),
            }
        )
    ),

    s({ trig = "draw" }, fmta([[\draw <> ;]], { i(1, "[]") }), { condition = tex_utils.in_tikz }),
    s(
        { trig = "drawl" },
        fmta([[\draw [<>] (<>, <>) -- (<>,<>);]], {
            i(1, "-latex"),
            i(2, "0"),
            i(3, "0"),
            i(4, "5"),
            i(5, "5"),
        }),
        { condition = tex_utils.in_tikz }
    ),

    s({ trig = "utikz", snippetType = "autosnippet" }, fmta([[\usetikzlibrary{<>}]], { i(1, "") })),

    -- shape
    s({ trig = "rec", snippetType = "autosnippet" }, fmta([[rectangle <>]], { i(1, "") })),
    s({ trig = "pos", snippetType = "autosnippet" }, fmta([[(<>,<>)]], { i(1, "0"), i(2, "0") })),
    s({ trig = "dc" }, fmta([[\definecolor{<>}{RGB}{<>}]], { i(1, "name"), i(2, "value") })),

    s(
        { trig = "line" },
        fmta([[\draw [<>] (<>, <>) -- (<>, <>); ]], {
            i(1, "->"),
            i(2, "x"),
            i(3, "y"),
            i(4, "a"),
            i(5, "b"),
        }),
        { condition = tex_utils.in_tikz }
    ),

    s(
        { trig = "helpline" },
        fmta(
            [[
        \draw [help lines] (<>,<>) grid  (<>,<>);
        ]],
            {
                i(1, "-3"),
                i(2, "-3"),
                i(3, "3"),
                i(4, "3"),
            },
            { condition = tex_utils.in_tikz }
        )
    ),

    s(
        { trig = "node" },
        fmta(
            [[
        \node [<>] (<>) at (<>,<>)  {<>};
        ]],
            {
                i(1, "thick, blue, circle , fill=blue!50"),
                i(2, "name"),
                i(3, "0"),
                i(4, "0"),
                i(5, "label"),
            },
            { condition = tex_utils.in_tikz }
        )
    ),
    s(
        { trig = "fill" },
        fmta(
            [[
        \fill [<>] (<>,<>) <>  {<>};
        ]],
            {
                i(1, "thick, blue, circle , fill=blue!50"),
                i(2, "0"),
                i(3, "0"),
                i(4, "shape"),
                i(5, "label"),
            },
            { condition = tex_utils.in_tikz }
        )
    ),

    s(
        { trig = "scope" },
        fmta(
            [[
        \begin{scope}[yshift=2cm]
         <>
        \end{scope}
        ]],
            {
                i(1, "code"),
            },
            { condition = tex_utils.in_tikz }
        )
    ),

    s(
        { trig = "fore" },
        fmta(
            [[
    \foreach \<> in {1, ...,<>}{
            <>
        }
        ]],
            {
                i(1, "var"),
                i(2, "num"),
                i(3, "body"),
            },
            { condition = tex_utils.in_tikz }
        )
    ),
}
