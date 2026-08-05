-- ======================
-- General
-- ======================

vim.opt.number = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autowrite = true
vim.opt.showcmd = true

-- Determine OS
if vim.fn.has("win32") == 1 then
    vim.opt.shell = "cmd.exe"
else
    vim.opt.shell = "zsh"
end

vim.opt.autoread = true
vim.opt.updatetime = 50
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 1
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
