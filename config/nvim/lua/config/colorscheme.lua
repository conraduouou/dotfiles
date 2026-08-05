-- ======================
-- Color scheme
-- ======================

-- Determine OS
if vim.fn.has("win32") == 0 then
    vim.cmd.colorscheme("oxocarbon")
end

