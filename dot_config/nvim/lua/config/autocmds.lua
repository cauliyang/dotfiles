-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

local function augroup(name)
  vim.api.nvim_create_augroup("yyl_" .. name, { clear = true })
end

-- Set filetype for .env and .env.* files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("env_filetype"),
  pattern = { "*.env", ".env.*" },
  callback = function()
    vim.opt_local.filetype = "sh"
  end,
})

-- Faster yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("fast_yank"),
  pattern = "*",
  desc = "Highlight text on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 200 })
  end,
})

-- CursorLine management
vim.api.nvim_create_autocmd("WinLeave", {
  group = augroup("cursorline_win_leave"),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  group = augroup("cursorline_win_enter"),
  callback = function()
    if vim.bo.filetype ~= "alpha" then
      vim.opt_local.cursorline = true
    end
  end,
})

-- Disable undo for certain files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("disable_undo"),
  pattern = { "/tmp/*", "COMMIT_EDITMSG", "MERGE_MSG", "*.tmp", "*.bak" },
  desc = "Disable undo for specific files",
  callback = function()
    vim.opt_local.undofile = false
  end,
})

-- Cargo.toml
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("cargo_toml_build_tools"),
  pattern = "Cargo.*toml",
  desc = "Set additional buffer keymaps for Cargo.toml",
  callback = function()
    local which_key = require("which-key")
    local theme = require("config.theme")
    local mappings = {
      mode = "n",
      buffer = vim.fn.bufnr(),
      { "gB", group = "Build Helpers", icon = theme.languages.toml },
      { "gBt", "<cmd>lua require('crates').toggle()<cr>", desc = "Toggle crates info" },
      { "gBr", "<cmd>lua require('crates').reload()<cr>", desc = "Reload crates info" },
      { "gBv", "<cmd>lua require('crates').show_versions_popup()<cr>", desc = "Show versions popup" },
      { "gBf", "<cmd>lua require('crates').show_features_popup()<cr>", desc = "Show features popup" },
      { "gBu", "<cmd>lua require('crates').update_crate()<cr>", desc = "Update crate" },
      { "gBa", "<cmd>lua require('crates').update_all_crates()<cr>", desc = "Update all crates" },
      { "gBU", "<cmd>lua require('crates').upgrade_crate()<cr>", desc = "Upgrade crate" },
      { "gBA", "<cmd>lua require('crates').upgrade_all_crates()<cr>", desc = "Upgrade all crates" },
      { "gBh", "<cmd>lua require('crates').open_homepage()<cr>", desc = "Open crate homepage" },
      { "gBR", "<cmd>lua require('crates').open_repository()<cr>", desc = "Open crate repository" },
      { "gBd", "<cmd>lua require('crates').open_documentation()<cr>", desc = "Open crate documentation" },
      { "gBc", "<cmd>lua require('crates').open_crates_io()<cr>", desc = "Open crates.io" },
    }
    which_key.add(mappings)

    local vmappings = {
      mode = "v",
      buffer = vim.fn.bufnr(),
      { "gB", group = "Build Helpers", icon = theme.languages.toml },
      { "gBu", "<cmd>lua require('crates').update_crates()<cr>", desc = "Update crates" },
      { "gBU", "<cmd>lua require('crates').upgrade_crates()<cr>", desc = "Upgrade crates" },
    }
    which_key.add(vmappings)
  end,
})
