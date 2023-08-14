return {

    s(
        { trig = "mmi", snippetType = "autosnippet" },
        fmta([[ \(<>\) ]], {
            i(1, "equation"),
        })
    ),

    s(
        { trig = "mmd", snippetType = "autosnippet" },
        fmta(
            [[ 
        \[
        <>
        \] ]],
            {
                i(1, "equation"),
            }
        )
    ),
}
