return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = true, -- Disable setting background
          terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false, -- Non focused panes set to alternative background
          module_default = true, -- Default enable value for modules
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
      })
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
    end,
  },
}
