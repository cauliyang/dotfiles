local get_visual = function(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1, ""))
    end
end

local function node_with_virtual_text(pos, node, text)
    local nodes
    if node.type == types.textNode then
        node.pos = 2
        nodes = { i(1), node }
    else
        node.pos = 1
        nodes = { node }
    end
    return sn(pos, nodes, {
        node_ext_opts = {
            active = {
                -- override highlight here ("GruvboxOrange").
                virt_text = { { text, "GruvboxOrange" } },
            },
        },
    })
end

local function nodes_with_virtual_text(nodes, opts)
    if opts == nil then
        opts = {}
    end
    local new_nodes = {}
    for pos, node in ipairs(nodes) do
        if opts.texts[pos] ~= nil then
            node = node_with_virtual_text(pos, node, opts.texts[pos])
        end
        table.insert(new_nodes, node)
    end
    return new_nodes
end

local function choice_text_node(pos, choices, opts)
    choices = nodes_with_virtual_text(choices, opts)
    return c(pos, choices, opts)
end

local ct = choice_text_node

-- see latex infinite list for the idea. Allows to keep adding arguments via choice nodes.
local function py_init()
    return sn(
        nil,
        c(1, {
            t(""),
            sn(1, {
                t(", "),
                i(1),
                d(2, py_init),
            }),
        })
    )
end

-- splits the string of the comma separated argument list into the arguments
-- and returns the text-/insert- or restore-nodes
local function to_init_assign(args)
    local tab = {}
    local a = args[1][1]
    if #a == 0 then
        table.insert(tab, t({ "", "\tpass" }))
    else
        local cnt = 1
        for e in string.gmatch(a, " ?([^,]*) ?") do
            if #e > 0 then
                table.insert(tab, t({ "", "\tself." }))
                -- use a restore-node to be able to keep the possibly changed attribute name
                -- (otherwise this function would always restore the default, even if the user
                -- changed the name)
                table.insert(tab, r(cnt, tostring(cnt), i(nil, e)))
                table.insert(tab, t(" = "))
                table.insert(tab, t(e))
                cnt = cnt + 1
            end
        end
    end
    return sn(nil, tab)
end

return {
    s(
        "d",
        fmt(
            [[
		def {func}({args}){ret}:
			{doc}{body}
	]],
            {
                func = i(1),
                args = i(2),
                ret = c(3, {
                    t(""),
                    sn(nil, {
                        t(" -> "),
                        i(1),
                    }),
                }),
                doc = isn(4, {
                    ct(1, {
                        t(""),
                        -- NOTE we need to surround the `fmt` with `sn` to make this work
                        sn(
                            1,
                            fmt(
                                [[
			"""{desc}"""

			]],
                                { desc = i(1) }
                            )
                        ),
                        sn(
                            2,
                            fmt(
                                [[
			"""{desc}

			Args:
			{args}

			Returns:
			{returns}
			"""

			]],
                                {
                                    desc = i(1),
                                    args = i(2), -- TODO should read from the args in the function
                                    returns = i(3),
                                }
                            )
                        ),
                    }, {
                        texts = {
                            "(no docstring)",
                            "(single line docstring)",
                            "(full docstring)",
                        },
                    }),
                }, "$PARENT_INDENT\t"),
                body = i(0),
            }
        )
    ),

    -- create the actual snippet
    s(
        "pyinit",
        fmt([[def __init__(self{}):{}]], {
            d(1, py_init),
            d(2, to_init_assign, { 1 }),
        })
    ),

    s(
        { trig = "op", wordTrig = false },
        fmt(
            [[
      Optional[{}]
      ]],
            {
                d(1, get_visual),
            }
        )
    ),
}
