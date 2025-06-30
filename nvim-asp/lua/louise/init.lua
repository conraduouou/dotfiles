-- for main editor buffers!
vim.opt.fillchars:append({ eob = "~" })

-- set new leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- for doc purposes!
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover docs" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show line diagnostic" })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end,
{ desc = "Previous diagnostic" }
)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end,
{ desc = "Next diagnostic" }
)

-- map keybinds 
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("n", "G", "Gzz")

-- map ESC keybinds
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("x", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("s", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { noremap = true, silent = true })

-- Visual mode goodness! from Primeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- for options
vim.opt.autowrite = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.updatetime = 50

-- for spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- for relative numbering
vim.opt.rnu = true
vim.opt.nu = true

-- for copying and pasting from clipboard using win32yank
vim.opt.clipboard:append("unnamedplus")

-- for telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<Leader>fg", require("telescope.builtin").live_grep, { desc = "Find String (live grep)" })
vim.keymap.set("n", "<Leader>fw", require("telescope.builtin").grep_string, { desc = "Find word under cursor" })

-- more LSP goodness
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>s", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })
