local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

return {
    s(
        { trig = "cref", snippetType = "autosnippet" },
        fmta([[~\cref{<>} ]], {
            d(1, get_visual),
        })
    ),
}
