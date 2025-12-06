-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Clear highlight with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Misc
-- vim.keymap.set("n", "<leader>w", "<cmd>w!<cr>", { desc = "Save buffer" })

-- set C-j and C-k to move when completion menu is open

-- Terminals
-- vim.keymap.set({ "n", "i", "t" }, "<c-\\>", function()
--   Snacks.terminal(nil, {
--     border = "rounded",
--     cwd = LazyVim.root.get(),
--     win = {
--       position = "float",
--       border = "rounded",
--       relative = "editor",
--     },
--     env = { TERM_TYPE = "float" },
--   })
-- end, { desc = "Float terminal" })
--
-- vim.keymap.set({ "n", "i", "t" }, "<c-s-\\>", function()
--   Snacks.terminal(nil, {
--     border = "rounded",
--     cwd = LazyVim.root.get(),
--     win = { position = "bottom", relative = "editor" },
--     env = { TERM_TYPE = "bottom" },
--   })
-- end, { desc = "Bottom terminal" })
