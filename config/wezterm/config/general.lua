local wezterm = require("wezterm")

local is_windows = wezterm.target_triple:find("windows") ~= nil
local ctrl = is_windows and "CTRL" or "CMD"

local M = {}

function M.apply(config)
    -- Default shell
    if is_windows then
        config.default_prog = { "pwsh.exe" }
    else
        config.default_prog = { "/bin/zsh", "-l" }
    end

    -- Kitty keyboard protocol
    config.enable_kitty_keyboard = true
    config.allow_win32_input_mode = false

    -- Multiplexer leader
    config.leader = {
        key = "b",
        mods = is_windows and "CTRL" or "CMD",
        timeout_milliseconds = 1000,
    }
end

return M
