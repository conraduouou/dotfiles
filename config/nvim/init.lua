-- Setting them before any plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Configs
if vim.g.vscode then
    require("init-vscode")
else
    require("init-wezterm")
end
