return {
    s(
        { trig = "fig", dscr = "insert an figure by using hugo shortcodes" },
        fmt('{{{{< figure src="{}" width={} >}}}}', {
            i(1, "image path"),
            i(2, "500"),
        })
    ),

    s(
        { trig = "cite" },
        fmt([[ {{{{<cite  {}  >}}}} ]], {
            i(1, "keyword"),
        })
    ),
}
