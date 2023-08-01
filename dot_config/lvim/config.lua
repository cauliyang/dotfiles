-- builtin parameters
require("user.builtin").config()

require("user.neovim").config()

require("user.neovide").config()

-- load plugins
reload("user.plugins")

-- Cmp
require("user.cmp").config()

-- load lsp
reload("user.lsp")

-- load telescope
require("user.telescope").config()

-- lualine
require("user.lualine").config()
-- require("user.lualine2").config()

-- bufferline
require("user.bufferline").config()

-- treesitter
require("user.treesitter").config()

-- load key mapping
reload("user.whichkey")

reload("user.autocommand")

-- Terminal
-- require("user.terminal").config()

-- load snip
reload("user.luasnip")

require("user.dap").config()
