-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Gracefully stop claudecode.nvim server on exit to avoid "no result callback found" error
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    local ok, claudecode = pcall(require, "claudecode")
    if ok and claudecode.stop then
      claudecode.stop()
    end
  end,
})
