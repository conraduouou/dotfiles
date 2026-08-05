-- ==========================================
-- Visuals
-- ==========================================

-- Enable true color
vim.opt.termguicolors = true

-- Cursor line
vim.opt.cursorline = true

-- Show matching brackets briefly
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Keep signcolumn visible
vim.opt.signcolumn = "yes"

-- Highlight current line number
vim.opt.cursorlineopt = "number"

-- Color column (optional)
vim.opt.colorcolumn = "100"

-- Don't show ~ after EOF
vim.opt.fillchars:append({
    eob = " ",
})

-- Nicer folds
vim.opt.fillchars:append({
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
})

-- Always show statusline
vim.opt.laststatus = 2

-- Smoother split appearance
vim.opt.splitkeep = "screen"

-- Popup menu
vim.opt.pumblend = 10
vim.opt.winblend = 10

-- Highlight yanked text
local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150,
        })
    end,
})
