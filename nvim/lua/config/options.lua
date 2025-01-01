-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"

vim.opt.signcolumn = "yes"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = true
vim.opt.breakindent = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undofile = true

-- Indentation - use tabs
vim.opt.expandtab = false      -- Use tabs instead of spaces
vim.opt.shiftwidth = 4         -- Indent width (4 spaces display)
vim.opt.tabstop = 4            -- Tab width (4 spaces display)
vim.opt.softtabstop = 4        -- Backspace removes 4 spaces
vim.opt.smartindent = true     -- Auto-indent new lines
vim.opt.autoindent = true      -- Copy indent from current line
