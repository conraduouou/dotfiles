-- ======================
-- Windows color scheme
-- ======================

vim.cmd([[
    highlight Normal guibg=none
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
    highlight NormalFloat guibg=NvimDarkGrey3
]])

vim.api.nvim_set_hl(0, "FzfLuaNormal", {
    bg = "#202020",
})
