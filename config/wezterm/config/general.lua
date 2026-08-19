local wezterm = require("wezterm")

local M = {}

function M.apply(config)
    -- Default shell
    config.default_prog = { "pwsh.exe" }

    -- Kitty keyboard protocol
    config.enable_kitty_keyboard = true
    config.allow_win32_input_mode = false

    -- Multiplexer leader
    config.leader = {
        key = "b",
        mods = "CTRL",
        timeout_milliseconds = 1000,
    }
end

return M
