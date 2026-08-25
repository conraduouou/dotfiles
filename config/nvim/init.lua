-- Setting them before any plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Configs
require("config.general")
require("config.lazy")
require("config.mappings")
require("config.colorscheme")
require("config.visuals")

-- LSP specifics
require("lsp.luals")
