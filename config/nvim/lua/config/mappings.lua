local map = vim.keymap.set

-- ======================
-- Normal mode
-- ======================

map("n", "<leader>h", "<Cmd>nohlsearch<CR>")

-- Alt scrolling
map({ "n", "v" }, "<A-d>", "<C-d>zz")
map({ "n", "v" }, "<A-u>", "<C-u>zz")
map({ "n", "v" }, "<A-e>", "<C-e>")
map({ "n", "v" }, "<A-y>", "<C-y>")

map("n", "G", "Gzz")

-- Jump list
map("n", "<A-o>", "<C-o>")
map("n", "<A-i>", "<C-i>")

-- Window navigation
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")

-- CoC navigation
map("n", "gd", "<Plug>(coc-definition)", { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)", { silent = true })
map("n", "gr", "<Plug>(coc-references)", { silent = true })

map("n", "K", function()
    vim.fn.CocActionAsync("doHover")
end)

-- ======================
-- Visual mode
-- ======================

map("v", ">", ">gv")
map("v", "<", "<gv")

-- ======================
-- Insert mode completion
-- ======================

map("i", "<Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

map("i", "<S-Tab>", function()
    return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

map("i", "<CR>", function()
    return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

-- ======================
-- Escape remaps
-- ======================

map({ "i", "v", "x", "s" }, "jk", "<Esc>")

-- ======================
-- Move lines
-- ======================

map("n", "<C-k>", ":<C-u>execute 'move .-' . (v:count1 + 1)<CR>==")
map("n", "<C-j>", ":<C-u>execute 'move .+' . v:count1<CR>==")

map("i", "<C-j>", "<Esc><Cmd>m .+1<CR>==gi")
map("i", "<C-k>", "<Esc><Cmd>m .-2<CR>==gi")

map("v", "<C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv")
map("v", "<C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv")

-- ======================
-- FZF
-- ======================

map("n", "<C-p>", "<Cmd>Files<CR>")

map("n", "<leader>ff", "<Cmd>Files<CR>")
map("n", "<leader>fb", "<Cmd>Buffers<CR>")
map("n", "<leader>fr", "<Cmd>Rg ")
map("n", "<leader>fh", "<Cmd>History<CR>")

map("n", "<leader>fl", "<Cmd>BLines<CR>")
map("n", "<leader>fL", "<Cmd>Lines<CR>")

map("n", "<leader>ft", "<Cmd>Tags<CR>")
map("n", "<leader>fT", "<Cmd>BTags<CR>")

map("n", "<leader>mm", "<Cmd>Maps<CR>")
map("n", "<leader>mk", "<Cmd>Marks<CR>")

map("n", "<leader>cc", "<Cmd>Commands<CR>")

map("n", "<leader>:", "<Cmd>History:<CR>")

-- ======================
-- Fugitive
-- ======================

map("n", "<leader>gs", "<Cmd>Git<CR>")
map("n", "<leader>gd", "<Cmd>Gdiffsplit<CR>")
map("n", "<leader>gb", "<Cmd>Git blame<CR>")
map("n", "<leader>gl", "<Cmd>Git log<CR>")

map("n", "<leader>ga", "<Cmd>Git add %<CR>")
map("n", "<leader>gA", "<Cmd>Git add .<CR>")

map("n", "<leader>gc", "<Cmd>Git commit<CR>")

map("n", "<leader>gp", "<Cmd>Git push<CR>")
map("n", "<leader>gP", "<Cmd>Git pull<CR>")

map("n", "<leader>ge", "<Cmd>Gedit<CR>")

-- ======================
-- Diagnostics (CoC)
-- ======================

map("n", "<leader>dp", "<Plug>(coc-diagnostic-prev)")
map("n", "<leader>dn", "<Plug>(coc-diagnostic-next)")
map("n", "<leader>dl", "<Cmd>CocList diagnostics<CR>")
map("n", "<leader>dh", "<Cmd>CocCommand diagnostics.showLineDiagnostics<CR>")

-- ======================
-- Miscellaneous
-- ======================

map({ "n", "v" }, "<A-a>", "<C-a>")
map({ "n", "v" }, "<A-x>", "<C-x>")
map("n", "<A-r>", "<C-r>")
