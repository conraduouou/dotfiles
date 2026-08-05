-- Setting them before any plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.general")
require("config.mappings")
require("config.lazy")
require("config.visuals")
