return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    enabled = true,
    config = function()
      local types = require("luasnip.util.types")
      local luasnip = require("luasnip")

      luasnip.config.set_config({ -- Setting LuaSnip config
        -- Don't store snippet history for less overhead
        history = false,
        -- Allow autotrigger snippets
        enable_autosnippets = true,
        -- For equivalent of UltiSnips visual selection
        store_selection_keys = "<Tab>",
        -- Event on which to check for exiting a snippet's region
        region_check_events = "InsertEnter",
        delete_check_events = "InsertLeave",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "Pink" } },
            },
          },
        },
      })

      -- Load snippets from a custom folder
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
      vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", { silent = true })
      vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", { silent = true })
      vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-prev-choice", {})
      vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})
    end,
  },
  {
    "evesdropper/luasnip-latex-snippets.nvim",
  },
}
