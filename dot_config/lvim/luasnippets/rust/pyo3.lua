local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

return {
    s(
        { trig = "pye", dscr = "PyResult" },
        fmt([[ PyResult<{}> ]], {
            i(1, "()"),
        })
    ),
}
