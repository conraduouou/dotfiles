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
-- vim.opt.colorcolumn = "100"

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


-- ==========================================
-- Statusline
-- ==========================================

-- _G.buffers = function()
--     local result = {}

--     for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--         if vim.api.nvim_buf_is_valid(bufnr)
--             and vim.api.nvim_buf_is_loaded(bufnr)
--             and vim.bo[bufnr].buflisted
--         then
--             local name = vim.fn.bufname(bufnr)

--             if name == "" then
--                 name = "No Name"
--             else
--                 name = vim.fn.fnamemodify(name, ":t")
--             end

--             if bufnr == vim.api.nvim_get_current_buf() then
--                 table.insert(result, "[" .. name .. "]")
--             else
--                 table.insert(result, name)
--             end
--         end
--     end

--     return table.concat(result, "  ")
-- end

-- _G.diagnostics = function()
--     local counts = vim.diagnostic.count(0)

--     local result = {}

--     if counts[vim.diagnostic.severity.ERROR] then
--         table.insert(result, "E:" .. counts[vim.diagnostic.severity.ERROR])
--     end

--     if counts[vim.diagnostic.severity.WARN] then
--         table.insert(result, "W:" .. counts[vim.diagnostic.severity.WARN])
--     end

--     if counts[vim.diagnostic.severity.INFO] then
--         table.insert(result, "I:" .. counts[vim.diagnostic.severity.INFO])
--     end

--     if counts[vim.diagnostic.severity.HINT] then
--         table.insert(result, "H:" .. counts[vim.diagnostic.severity.HINT])
--     end

--     return table.concat(result, " ")
-- end

-- vim.o.statusline = "%{v:lua.buffers()}%= %{v:lua.diagnostics()}  %l:%c"
