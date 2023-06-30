-- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets

local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

local get_visual_without_space = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

return {

    s(
        { trig = "pfn", dscr = "insert public function" },
        fmt(
            [[
    {} fn {}({}, {}:{}) -> {} {{
          {}
    }}
    ]],
            {
                c(1, { t("pub"), t("") }),

                i(2, "name"),

                c(3, {
                    t("self"),
                    t("mut self"),
                    t("&self"),
                    t("&mut self"),
                }),
                i(4, "arg"),
                i(5, "Type"),
                i(6, "RetType"),
                i(0, "unimplemented!()"),
            }
        )
    ),

    s("derivedebug", t("#[derive(Debug)]")),
    s("deadcode", t("#[allow(dead_code)]")),
    s("allowfreedom", t("#![allow(clippy::disallowed_names, unused_variables, dead_code)]")),

    s(
        { trig = "testcfg", dscr = "test cfg" },
        fmt(
            [[
    #[cfg(test)]
    mod {} {{
        use super::*;

        #[test]
        fn {}() {{
            {}
        }}
    }}
    ]],
            {
                i(1, "name"),
                i(2, "name"),
                i(0, "unimplemented!()"),
            }
        )
    ),

    s(
        { trig = "new", dscr = "create constructor" },
        fmt(
            [[
            fn new({}:{}) -> Self {{
                {}
             }}
    ]],
            {
                i(1, "arg"),
                i(2, "Type"),
                i(0, "unimplemented!()"),
            }
        )
    ),

    s(
        { trig = "op", wordTrig = false },
        fmt(
            [[
      Option<{}>
      ]],
            {
                d(1, get_visual),
            }
        )
    ),

    s(
        { trig = "so", wordTrig = false },
        fmt(
            [[
      Some({})
      ]],
            {
                d(1, get_visual),
            }
        )
    ),

    s(
        { trig = "ok", wordTrig = false },
        fmt(
            [[
        Ok({})
        ]],
            {
                d(1, get_visual),
            }
        )
    ),

    s(
        { trig = "pro", wordTrig = false },
        fmt(
            [[
        #[{}]
        ]],
            {
                d(1, get_visual_without_space),
            }
        )
    ),
    s(
        { trig = "res", wordTrig = false },
        fmt(
            [[
        Result<{}>
        ]],
            {
                d(1, get_visual_without_space),
            }
        )
    ),
}
