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


-- muscle memory remove highlight
map("n", "<leader>h", "<Cmd>nohlsearch<CR>",  { desc = "Remove highlights" })

-- Scrolling
map({ "n", "v" }, "<C-d>", "<C-d>zz",         { desc = "Half-page down and center" })
map({ "n", "v" }, "<C-u>", "<C-u>zz",         { desc = "Half-page up and center" })

-- Jumps
map("n", "<C-o>", "<C-o>zz",                  { desc = "Half-page down and center" })
map("n", "<C-i>", "<C-i>zz",                  { desc = "Half-page up and center" })

-- Buffer switching
map("n", "<C-S-h>", "<cmd>bprevious<cr>",     { desc = "Previous buffer" })
map("n", "<C-S-l>", "<cmd>bnext<cr>",         { desc = "Next buffer" })

-- Center when going to bottom
map("n", "G", "Gzz")

-- CoC navigation
map("n", "gd", "<Plug>(coc-definition)",      { silent = true })
map("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
map("n", "gi", "<Plug>(coc-implementation)",  { silent = true })
map("n", "gr", "<Plug>(coc-references)",      { silent = true })

map("n", "K", function()
    vim.fn.CocActionAsync("doHover")
end)


-- ======================
-- Visual mode
-- ======================

map("v", ">", ">gv",                          { desc = "Indent forwards" })
map("v", "<", "<gv",                          { desc = "Indent backwards" })


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

map("i", "jk", "<Esc>",                       { desc = "Quick escape" })


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

map("n", "<leader>bp", "<cmd>bprevious<cr>",  { desc = "Previous buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>",      { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>enew<cr>",       { desc = "New buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>",    { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#<cr>",     { desc = "Delete other buffers" })
map("n", "<leader>bl", "<cmd>ls<cr>",         { desc = "List buffers" })
map("n", "<leader>br", "<cmd>file<cr>",       { desc = "Rename buffer" })
map("n", "<leader>bs", "<cmd>buffer<space>",  { desc = "Switch buffer" })


-- ======================
-- Windows namespace
-- ======================

map("n", "<leader>w'", "<C-w>s",              { desc = "Split window horizontally" })
map("n", "<leader>w;", "<C-w>v",              { desc = "Split window vertically" })
map("n", "<leader>we", "<C-w>=",              { desc = "Equalize size" })
map("n", "<leader>wx", "<C-w>q",              { desc = "Close window" })

local movement_keys = {
    h = true,
    j = true,
    k = true,
    l = true,
}

-- resize in logical directions
local function directional_resize(key)
    local current = vim.fn.winnr()
    local amount = movement_keys[key] and 1 or 5
    key = string.lower(key)
    
    -- if the current window is the only window in the column
    local is_only_vertical = vim.fn.winnr("1k") == vim.fn.winnr("1j")

    if (not is_only_vertical) and (key == "j" or key == "k") then
        -- if the current window is not at the bottom
        if vim.fn.winnr("1j") ~= current then
            if key == "j" then
                vim.cmd("resize +" .. amount)
            else
                vim.cmd("resize -" .. amount)
            end
        else
            if key == "j" then
                vim.cmd("resize -" .. amount)
            else
                vim.cmd("resize +" .. amount)
            end
        end
    elseif key == "h" or key == "l" then
        if current == vim.fn.winnr("1l") then
            if key == "h" then
                vim.cmd("vertical resize +" .. amount)
            else
                vim.cmd("vertical resize -" .. amount)
            end
        else
            if key == "h" then
                vim.cmd("vertical resize -" .. amount)
            else
                vim.cmd("vertical resize +" .. amount)
            end
        end
    end
end

-- For repeatable mappings, really just to emulate tmux's -r behavior
local function repeatable(key)
    local timeout = 500

    directional_resize(key)

    local timer = vim.uv.new_timer()

    local name = "resize"
    local id = vim.api.nvim_create_namespace(name)

    local function stop()
        if not timer:is_closing() then
            timer:stop()
            timer:close()
        end

        vim.on_key(nil, id)
    end

    local function callback(key, typed)
        if movement_keys[string.lower(typed)] then
            directional_resize(typed)
            timer:stop()
            timer:start(timeout, 0, stop)
            return ""
        else
            stop()
        end
    end

    vim.on_key(callback, id)

    timer:start(timeout, 0, stop)
end

map("n", "<leader>wh", function()
  repeatable("h")
end, { desc = "Resize left fine" })

map("n", "<leader>wl", function()
  repeatable("l")
end, { desc = "Resize right fine" })

map("n", "<leader>wj", function()
  repeatable("j")
end, { desc = "Resize up fine" })

map("n", "<leader>wk", function()
  repeatable("k")
end, { desc = "Resize down fine" })

map("n", "<leader>wH", function()
  repeatable("H")
end, { desc = "Resize left coarse" })

map("n", "<leader>wL", function()
  repeatable("L")
end, { desc = "Resize right coarse" })

map("n", "<leader>wJ", function()
  repeatable("J")
end, { desc = "Resize up coarse" })

map("n", "<leader>wK", function()
  repeatable("K")
end, { desc = "Resize down coarse" })


-- ======================
-- fzf
-- ======================

local fzf = require("fzf-lua")

map("n", "<leader>ff", fzf.files,             { desc = "Find files" })
map("n", "<leader>fb", fzf.buffers,           { desc = "Find buffers" })
map("n", "<leader>fr", fzf.live_grep,         { desc = "Live grep" })
map("n", "<leader>fh", fzf.oldfiles,          { desc = "Find recent files" })

map("n", "<leader>fl", fzf.blines,            { desc = "Search buffer lines" })
map("n", "<leader>fL", fzf.lines,             { desc = "Search all lines" })

map("n", "<leader>ft", fzf.tags,              { desc = "Find tags" })
map("n", "<leader>fT", fzf.btags,             { desc = "Find buffer tags" })

map("n", "<leader>mm", fzf.keymaps,           { desc = "Find keymaps" })
map("n", "<leader>mk", fzf.marks,             { desc = "Find marks" })

map("n", "<leader>cc", fzf.commands,          { desc = "Find commands" })

map("n", "<leader>:", fzf.command_history,    { desc = "Command history" })


-- ======================
-- Fugitive
-- ======================

map("n", "<leader>gs", "<Cmd>Git<CR>",        { desc = "Git status" })
map("n", "<leader>gd", "<Cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
map("n", "<leader>gb", "<Cmd>Git blame<CR>",  { desc = "Git blame" })
map("n", "<leader>gl", "<Cmd>Git log<CR>",    { desc = "Git log" })

map("n", "<leader>ga", "<Cmd>Git add %<CR>",  { desc = "Git add current file" })
map("n", "<leader>gA", "<Cmd>Git add .<CR>",  { desc = "Git add all files" })

map("n", "<leader>gc", "<Cmd>Git commit<CR>", { desc = "Git commit" })

map("n", "<leader>gp", "<Cmd>Git push<CR>",   { desc = "Git push" })
map("n", "<leader>gP", "<Cmd>Git pull<CR>",   { desc = "Git pull" })

map("n", "<leader>ge", "<Cmd>Gedit<CR>",      { desc = "Edit Git version" })


-- ======================
-- Diagnostics (CoC)
-- ======================

map("n", "<leader>dp", "<Plug>(coc-diagnostic-prev)",       { desc = "Previous diagnostic" })
map("n", "<leader>dn", "<Plug>(coc-diagnostic-next)",       { desc = "Next diagnostic" })
map("n", "<leader>dl", "<Cmd>CocList diagnostics<CR>",      { desc = "List diagnostics" })
map("n", "<leader>dh", "<Cmd>CocCommand diagnostics.showLineDiagnostics<CR>", { desc = "Show line diagnostics" })

-- ======================
-- Miscellaneous
-- ======================

map("c", "<C-v>", "<C-r>+",                  { desc = "Paste from clipboard in command-line mode" })
