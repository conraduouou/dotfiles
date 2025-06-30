require("config.lazy")

-- setup diagnostics for LSP
require("config.diagnostics")

require("lazy").setup("plugins")

vim.cmd.colorscheme("tokyonight")

-- for LSPs
require("lsp.lua-language-server")

-- set keybinds after everything
require("louise")
