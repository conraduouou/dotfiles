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

vim.api.nvim_set_hl(0, "FzfLuaNormal", {
    bg = "#202020",
})
