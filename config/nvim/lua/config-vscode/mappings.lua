local map = vim.keymap.set
local vscode = require("vscode")

-- ======================
-- Normal mode
-- ======================

map("n", "<Esc>", "<Esc>", { desc = "Escape" })

-- muscle memory remove highlight
map("n", "<leader>h", "<Cmd>nohlsearch<CR>",  { desc = "Remove highlights" })

-- Center when going to bottom
map("n", "G", "Gzz")

-- Focus navigation (handled by keybindings.json)

-- Jumps (handled by keybindings.json)

-- Buffer switching (handled by keybindings.json)

-- Scrolling (has bugs currently)
-- map({ "n", "v" }, "<C-d>", "<C-d>zz",         { desc = "Half-page down and center" })
-- map({ "n", "v" }, "<C-u>", "<C-u>zz",         { desc = "Half-page up and center" })

-- ======================
-- Visual mode
-- ======================

map("v", ">", ">gv",                          { desc = "Indent forwards" })
map("v", "<", "<gv",                          { desc = "Indent backwards" })


-- ======================
-- Insert mode
-- ======================

map("i", "<C-h>", "<C-o>h")
map("i", "<C-j>", "<C-o>j")
map("i", "<C-k>", "<C-o>k")
map("i", "<C-l>", "<C-o>l")


-- ======================
-- Escape remaps
-- ======================

map("i", "jk", "<Esc>",                       { desc = "Quick escape" })


-- ======================
-- Buffers namespace
-- ======================

map("n", "<leader>bp", function()
    vscode.action("workbench.action.previousEditor")
end,  { desc = "Previous buffer" })
map("n", "<leader>bn", function()
    vscode.action("workbench.action.nextEditor")
end,      { desc = "Next buffer" })
map("n", "<leader>bb", function()
    vscode.action("workbench.action.files.newUntitledFile")
end,       { desc = "New buffer" })
map("n", "<leader>bo", function()
    vscode.action("workbench.action.closeOtherEditors")
end,     { desc = "Delete other buffers" })
map("n", "<leader>bl", function()
    vscode.action("workbench.action.showAllEditors")
end,         { desc = "List buffers" })
map("n", "<leader>bx", function()
    vscode.action("workbench.action.closeActiveEditor")
end,     { desc = "Delete buffer" })


-- ======================
-- Windows namespace
-- ======================

map("n", "<leader>w'", function()
    vscode.action("workbench.action.splitEditorDown")
end, { desc = "Split window horizontally" })
map("n", "<leader>w;", function()
    vscode.action("workbench.action.splitEditorRight")
end, { desc = "Split window vertically" })
map("n", "<leader>we", function()
    vscode.action("workbench.action.evenEditorWidths")
end, { desc = "Equalize size" })
map("n", "<leader>wx", function()
    vscode.action("workbench.action.closeGroup")
end, { desc = "Close window" })


-- ======================
-- Find
-- ======================

map("n", "<leader>ff", function()
    vscode.action("workbench.action.quickOpen")
end, { desc = "Find files" })

map("n", "<leader>fb", function()
    vscode.action("workbench.action.showAllEditors")
end, { desc = "Find buffers" })

map("n", "<leader>fr", function()
    vscode.action("workbench.action.findInFiles")
end, { desc = "Live grep" })

map("n", "<leader>fh", function()
    vscode.action("workbench.action.quickOpen")
end, { desc = "Find recent files" })

map("n", "<leader>fl", function()
    vscode.action("actions.find")
end, { desc = "Search buffer lines" })

map("n", "<leader>fL", function()
    vscode.action("workbench.action.findInFiles")
end, { desc = "Search all lines" })

map("n", "<leader>ft", function()
    vscode.action("workbench.action.gotoSymbol")
end, { desc = "Find tags" })

map("n", "<leader>fT", function()
    vscode.action("workbench.action.gotoSymbol")
end, { desc = "Find buffer tags" })

map("n", "<leader>fk", function()
    vscode.action("workbench.action.openGlobalKeybindings")
end, { desc = "Find keymaps" })

map("n", "<leader>fc", function()
    vscode.action("workbench.action.showCommands")
end, { desc = "Find commands" })


-- ======================
-- Git
-- ======================

map("n", "<leader>gs", function()
    vscode.action("workbench.view.scm")
end, { desc = "Git status" })

map("n", "<leader>gd", function()
    vscode.action("git.openChange")
end, { desc = "Git diff" })

map("n", "<leader>ga", function()
    vscode.action("git.stage")
end, { desc = "Git stage current file" })

map("n", "<leader>gA", function()
    vscode.action("git.stageAll")
end, { desc = "Git stage all files" })

map("n", "<leader>gc", function()
    vscode.action("git.commit")
end, { desc = "Git commit" })

map("n", "<leader>gp", function()
    vscode.action("git.push")
end, { desc = "Git push" })

map("n", "<leader>gP", function()
    vscode.action("git.pull")
end, { desc = "Git pull" })


-- ======================
-- Diagnostics
-- ======================

map("n", "<leader>dl", function()
    vscode.action("workbench.actions.view.problems")
end, { desc = "List document diagnostics" })

map("n", "<leader>dd", function()
    vscode.action("editor.action.showHover")
end, { desc = "Show line diagnostics" })


-- ======================
-- LSP navigation
-- ======================

map("n", "gd", function()
    vscode.action("editor.action.revealDefinition")
end, { desc = "Go to definition" })

map("n", "gy", function()
    vscode.action("editor.action.goToTypeDefinition")
end, { desc = "Go to type definition" })

map("n", "gi", function()
    vscode.action("editor.action.goToImplementation")
end, { desc = "Go to implementation" })

map("n", "gr", function()
    vscode.action("editor.action.referenceSearch.trigger")
end, { desc = "Go to references" })

map("n", "<leader>ll", function()
    vscode.action("editor.action.showHover")
end, { desc = "Show hover information" })


-- ======================
-- Miscellaneous
-- ======================

map("c", "<C-v>", "<C-r>+",                  { desc = "Paste from clipboard in command-line mode" })