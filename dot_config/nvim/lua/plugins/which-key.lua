local icons = require("config.theme").icons
return {
  "folke/which-key.nvim",
  opts = {
    preset = "helix",
    plugins = {
      presets = {
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        operators = false, -- adds help for operators like d, y, ...
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
    spec = {
      {
        { "<leader>bw", "<cmd>w<cr>", desc = "Save Buffer", icon = icons.ok },
      },
    },
  },
}
