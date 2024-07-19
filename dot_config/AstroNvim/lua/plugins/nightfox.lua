return {
  "EdenEast/nightfox.nvim",
  opts = {
    options = {
      -- Compiled file's destination location
      compile_path = vim.fn.stdpath "cache" .. "/nightfox",
      compile_file_suffix = "_compiled", -- Compiled file suffix
      transparent = true, -- Disable setting background
      terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
      dim_inactive = true, -- Non focused panes set to alternative background
      module_default = true, -- Default enable value for modules
      modules = {
        aerial = true,
        cmp = true,
        ["dap-ui"] = true,
        dashboard = true,
        diagnostic = true,
        gitsigns = true,
        native_lsp = true,
        neotree = true,
        notify = true,
        symbol_outline = true,
        telescope = true,
        treesitter = true,
        whichkey = true,
      },
      styles = { -- Style to be applied to different syntax groups
        comments = "italic", -- Value is any valid attr-list value `:help attr-list`
        conditionals = "NONE",
        constants = "NONE",
        functions = "NONE",
        keywords = "italic",
        types = "italic,bold",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        variables = "NONE",
      },
      inverse = { -- Inverse highlight for different types
        match_paren = true,
        visual = true,
        search = true,
      },
    },
    groups = { all = { NormalFloat = { link = "Normal" } } },
  },
}
