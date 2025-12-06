return {
  "saghen/blink.cmp",
  enabled = true,
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      ["<C-p>"] = { "scroll_documentation_up", "fallback" },
      ["<C-n>"] = { "scroll_documentation_down", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },

      -- config <C-m> to accept the current completion item
      ["<C-m>"] = { "accept", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
    },
  },
}
