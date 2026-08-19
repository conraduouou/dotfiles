local wezterm = require("wezterm")

local M = {}

local function truncate(title, width)
    if #title > width then
        return title:sub(1, width - 1) .. "…"
    end

    return title
end

wezterm.on("format-tab-title", function(tab)
    local title = truncate(tab.active_pane.title, 10)

    if tab.is_active then
        return string.format("   %-20s ", title)
    end

    return string.format("  • %-20s ", title)
end)

function M.apply(config)
    -- Font
    config.font = wezterm.font("Cascadia Mono")

    if wezterm.target_triple:find("windows") then
        config.font_size = 10.0
    else
        config.font_size = 16.0
    end

    -- Cursor
    config.default_cursor_style = "BlinkingBar"

    -- Window
    config.window_background_opacity = 0.8
    config.window_decorations = "RESIZE"

    config.window_padding = {
        left = 20,
        right = 20,
        top = 20,
        bottom = 20,
    }
    config.inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.4,
    }

    -- Tabs
    config.use_fancy_tab_bar = false

    config.colors = {
        tab_bar = {
            background = "rgba(00, 00, 00, 0.75)",

            active_tab = {
                bg_color = "rgba(05, 05, 05, 0.80)",
                fg_color = "#ffffff",
            },

            inactive_tab = {
                bg_color = "rgba(20, 20, 20, 0.75)",
                fg_color = "#aaaaaa",
            },

            inactive_tab_hover = {
                bg_color = "rgba(15, 15, 15, 0.80)",
                fg_color = "#dddddd",
            },

            new_tab = {
                bg_color = "rgb(00, 00, 00, 0.75)",
                fg_color = "#aaaaaa",
            },

            new_tab_hover = {
                bg_color = "rgba(30, 30, 30, 0.95)",
                fg_color = "#dddddd",
            },
        },
    }
end

return M
