-- ======================
-- Color scheme
-- ======================

-- Determine OS
if vim.fn.has("win32") == 0 then
    vim.cmd.colorscheme("oxocarbon")
end

vim.cmd([[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
]])
