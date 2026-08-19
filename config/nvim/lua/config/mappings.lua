local map = vim.keymap.set

-- ======================
-- Normal mode
-- ======================

-- to be able to navigate with panes and nvim, like vim-tmux-navigator
local function activate_pane(direction)
    -- for future support of other terminals
    if vim.env.TERM_PROGRAM == "WezTerm" then
        vim.system({
            "wezterm",
            "cli",
            "activate-pane-direction",
            direction,
        })
    end
end
local function smart_navigate(direction, terminal_direction)
    local current = vim.fn.winnr()
    local target = vim.fn.winnr(direction)

    if target ~= current then
        vim.cmd("wincmd " .. direction)
    else
        activate_pane(terminal_direction)
    end
end

map("n", "<C-h>", function()
    smart_navigate("h", "left")
end)

map("n", "<C-j>", function()
    smart_navigate("j", "down")
end)

map("n", "<C-k>", function()
    smart_navigate("k", "up")
end)

map("n", "<C-l>", function()
    smart_navigate("l", "right")
end)

map("n", "<leader>h", "<Cmd>nohlsearch<CR>")

-- Scrolling
map({ "n", "v" }, "<C-d>", "<C-d>zz")
map({ "n", "v" }, "<C-u>", "<C-u>zz")

-- Buffer switching
map("n", "<C-S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<C-S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Center when going to bottom
map("n", "G", "Gzz")

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

map("i", "jk", "<Esc>")

-- ======================
-- Move lines
-- ======================

-- map("n", "<C-k>", ":<C-u>execute 'move .-' . (v:count1 + 1)<CR>==")
-- map("n", "<C-j>", ":<C-u>execute 'move .+' . v:count1<CR>==")

-- map("i", "<C-j>", "<Esc><Cmd>m .+1<CR>==gi")
-- map("i", "<C-k>", "<Esc><Cmd>m .-2<CR>==gi")

-- map("v", "<C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv")
-- map("v", "<C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv")

-- ======================
-- Buffers namespace
-- ======================

map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>enew<cr>", { desc = "New buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Delete other buffers" })
map("n", "<leader>bl", "<cmd>ls<cr>", { desc = "List buffers" })
map("n", "<leader>br", "<cmd>file<cr>", { desc = "Rename buffer" })
map("n", "<leader>bs", "<cmd>buffer<space>", { desc = "Switch buffer" })

-- ======================
-- fzf
-- ======================

local fzf = require("fzf-lua")

map("n", "<leader>ff", fzf.files)
map("n", "<leader>fb", fzf.buffers)
map("n", "<leader>fr", fzf.live_grep)
map("n", "<leader>fh", fzf.oldfiles)

map("n", "<leader>fl", fzf.blines)
map("n", "<leader>fL", fzf.lines)

map("n", "<leader>ft", fzf.tags)
map("n", "<leader>fT", fzf.btags)

map("n", "<leader>mm", fzf.keymaps)
map("n", "<leader>mk", fzf.marks)

map("n", "<leader>cc", fzf.commands)

map("n", "<leader>:", fzf.command_history)

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
