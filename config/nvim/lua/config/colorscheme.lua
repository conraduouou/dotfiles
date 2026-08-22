-- ======================
-- Color scheme
-- ======================

-- Determine OS
if vim.fn.has("win32") == 0 then
    require("config.colors-macos")
else
    require("config.colors-windows")
end

