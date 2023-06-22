-- Some LaTeX-specific conditional expansion functions (requires VimTeX)

local tex_utils = {}

tex_utils.in_mathzone = function() -- math context detection
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

tex_utils.in_text = function()
    return not tex_utils.in_mathzone()
end

tex_utils.in_comment = function() -- comment detection
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

tex_utils.in_env = function(name) -- generic environment detection
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
    return tex_utils.in_env("equation")
end

tex_utils.in_itemize = function() -- itemize environment detection
    return tex_utils.in_env("itemize")
end

tex_utils.in_tikz = function() -- TikZ picture environment detection
    return tex_utils.in_env("tikzpicture")
end

-- A logical OR of `line_begin` and the regTrig '[^%a]trig'
function line_begin_or_non_letter(line_to_cursor, matched_trigger)
    local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
    local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
    return line_begin or non_letter
end

local line_begin = function(line_to_cursor, matched_trigger)
    -- +1 because `string.sub("abcd", 1, -2)` -> abc
    return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

-- -- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
-- local get_visual = function(args, parent)
-- 	if #parent.snippet.env.LS_SELECT_RAW > 0 then
-- 		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
-- 	else -- If LS_SELECT_RAW is empty, return a blank insert node
-- 		return sn(nil, i(1))
-- 	end
-- end

return {
    --  Insert hyperlink
    s(
        { trig = "href", describe = "insert a hyperlink" },
        fmta(
            [[
      \href{<>}{<>}
      ]],
            {
                i(1, "url"),
                i(2, "text"),
            }
        )
    ),

    -- TYPEWRITER i.e. \texttt
    s(
        { trig = "([^%a])sd", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
        fmta("<>\\texttt{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex_utils.in_text }
    ),

    -- ITALIC i.e. \textit
    s(
        { trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\textit{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),

    -- BOLD i.e. \textbf
    s(
        { trig = "tbb", snippetType = "autosnippet" },
        fmta("\\textbf{<>}", {
            d(1, get_visual),
        })
    ),

    -- BOLD i.e. \emph
    s(
        { trig = "emp", snippetType = "autosnippet" },
        fmta("\\emph{<>}", {
            d(1, get_visual),
        })
    ),

    -- MATH ROMAN i.e. \mathrm
    s(
        { trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathrm{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    s(
        { trig = "([^%a])mtt", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathtt{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),

    -- MATH CALIGRAPHY i.e. \mathcal
    s(
        { trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathcal{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- MATH BOLDFACE i.e. \mathbf
    s(
        { trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathbf{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- MATH BLACKBOARD i.e. \mathbb
    s(
        { trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\mathbb{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        })
    ),
    -- REGULAR TEXT i.e. \text (in math environments)
    s(
        { trig = "([^%a])tee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta("<>\\text{<>}", {
            f(function(_, snip)
                return snip.captures[1]
            end),
            d(1, get_visual),
        }),
        { condition = tex_utils.in_mathzone }
    ),
}
