-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Leader+h → clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Alt+d / Alt+u → scroll and center
vim.keymap.set("n", "<A-d>", "<C-d>", opts)
vim.keymap.set("n", "<A-u>", "<C-u>", opts)

-- Alt+o / Alt+i → jump to previous and next
vim.keymap.set("n", "<A-o>", "<C-o>", opts)
vim.keymap.set("n", "<A-i>", "<C-i>", opts)

-- remap window navigation to Alt + h/j/k/l
vim.keymap.set("n", "<A-h>", "<C-w>h", opts)
vim.keymap.set("n", "<A-j>", "<C-w>j", opts)
vim.keymap.set("n", "<A-k>", "<C-w>k", opts)
vim.keymap.set("n", "<A-l>", "<C-w>l", opts)

-- remap lazyvim alt keymaps to ctrl
vim.keymap.set("n", "<C-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<C-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- modes: i = insert, v = visual, s = select, o = operator-pending
local modes = { "i", "v", "s", "o" }

for _, mode in ipairs(modes) do
  vim.keymap.set(mode, "jk", "<Esc>", { noremap = true, silent = true })
end
