local opt = vim.opt

-- ======================
-- General
-- ======================

opt.number = true
opt.wrap = false
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.autowrite = true
opt.showcmd = true

-- Determine OS
if vim.fn.has("win32") == 1 then
    opt.shell = "cmd.exe"
else
    opt.shell = "zsh"
end

opt.autoread = true
opt.updatetime = 50
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 1
opt.expandtab = true
opt.ignorecase = true
opt.smartcase = true
