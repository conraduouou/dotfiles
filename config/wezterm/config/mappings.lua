local wezterm = require("wezterm")
local act = wezterm.action

local is_windows = wezterm.target_triple:find("windows") ~= nil
local ctrl = is_windows and "CTRL" or "CMD"

local M = {}

-- helpers
local function is_process(pane, pattern)
    local process = pane:get_foreground_process_info()

    if not process or not process.executable then
        return false
    end

    local executable = process.executable:lower()

    return executable:match(pattern) ~= nil
end

local function is_neovim(pane)
    return is_process(pane, "[/\\]nvim%.exe$")
        or is_process(pane, "[/]nvim$")
end

local function is_fzf(pane)
    return is_process(pane, "[/\\]fzf%.exe$")
        or is_process(pane, "[/]fzf$")
end

-- translate cmd to ctrl when in neovim or fzf
local function cmd_or_ctrl(key, action)
    return wezterm.action_callback(function(window, pane)
        if is_neovim(pane) or is_fzf(pane) then
            window:perform_action(
                act.SendKey {
                    key = key,
                    mods = "CTRL",
                },
                pane
            )
        else
            window:perform_action(action, pane)
        end
    end)
end

-- Handle repeating actions
local function repeatable(action)
    return wezterm.action_callback(
        function(window, pane)
            window:perform_action(action, pane)
            window:perform_action(
                act.ActivateKeyTable {
                    name = "manipulate",
                    one_shot = false,
                    timeout_milliseconds = 500,
                },
                pane
            )
        end
    )
end

function M.apply(config)
    -- I set my own mappings, thank you very much
    config.disable_default_key_bindings = true

    config.keys = {
        -- =========================================
        -- Instant Navigation
        -- =========================================

        {
            key = "h",
            mods = ctrl,
            action = cmd_or_ctrl(
                "h",
                act.ActivatePaneDirection("Left")
            ),
        },
        {
            key = "j",
            mods = ctrl,
            action = cmd_or_ctrl(
                "j",
                act.ActivatePaneDirection("Down")
            ),
        },
        {
            key = "k",
            mods = ctrl,
            action = cmd_or_ctrl(
                "k",
                act.ActivatePaneDirection("Up")
            ),
        },
        {
            key = "l",
            mods = ctrl,
            action = cmd_or_ctrl(
                "l",
                act.ActivatePaneDirection("Right")
            ),
        },

        -- =========================================
        -- Splits
        -- =========================================

        {
            key = ";",
            mods = "LEADER",
            action = act.SplitHorizontal({
                domain = "CurrentPaneDomain",
            }),
        },
        {
            key = "'",
            mods = "LEADER",
            action = act.SplitVertical({
                domain = "CurrentPaneDomain",
            }),
        },

        -- =========================================
        -- Pane Resizing
        -- =========================================

        {
            key = "z",
            mods = "LEADER",
            action = act.TogglePaneZoomState,
        },

        -- Fine resize
        {
            key = "h",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Left", 1 }
            ),
        },

        {
            key = "j",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Down", 1 }
            ),
        },

        {
            key = "k",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Up", 1 }
            ),
        },

        {
            key = "l",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Right", 1 }
            ),
        },

        -- Coarse resize
        {
            key = "H",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Left", 5 }
            ),
        },

        {
            key = "J",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Down", 5 }
            ),
        },

        {
            key = "K",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Up", 5 }
            ),
        },

        {
            key = "L",
            mods = "LEADER",
            action = repeatable(
                act.AdjustPaneSize { "Right", 5 }
            ),
        },

        -- =========================================
        -- Tabs
        -- =========================================

        -- Ctrl-Alt-h / Ctrl-Alt-l → previous / next tab
        {
            key = "h",
            mods = ctrl .. "|ALT",
            action = act.ActivateTabRelative(-1),
        },
        {
            key = "l",
            mods = ctrl .. "|ALT",
            action = act.ActivateTabRelative(1),
        },

        -- Ctrl-0 through Ctrl-9
        {
            key = "0",
            mods = ctrl,
            action = act.ActivateTab(0),
        },
        {
            key = "1",
            mods = ctrl,
            action = act.ActivateTab(1),
        },
        {
            key = "2",
            mods = ctrl,
            action = act.ActivateTab(2),
        },
        {
            key = "3",
            mods = ctrl,
            action = act.ActivateTab(3),
        },
        {
            key = "4",
            mods = ctrl,
            action = act.ActivateTab(4),
        },
        {
            key = "5",
            mods = ctrl,
            action = act.ActivateTab(5),
        },
        {
            key = "6",
            mods = ctrl,
            action = act.ActivateTab(6),
        },
        {
            key = "7",
            mods = ctrl,
            action = act.ActivateTab(7),
        },
        {
            key = "8",
            mods = ctrl,
            action = act.ActivateTab(8),
        },
        {
            key = "9",
            mods = ctrl,
            action = act.ActivateTab(9),
        },

        -- =========================================
        -- Tab Management
        -- =========================================

        {
            key = "t",
            mods = "LEADER",
            action = act.SpawnTab("CurrentPaneDomain"),
        },

        {
            key = "w",
            mods = "LEADER",
            action = act.CloseCurrentTab({
                confirm = true,
            }),
        },

        -- =========================================
        -- Pane Rotation
        -- =========================================

        {
            key = "|",
            mods = "LEADER",
            action = act.RotatePanes("Clockwise"),
        },
        {
            key = "\\",
            mods = "LEADER",
            action = act.RotatePanes("CounterClockwise"),
        },

        -- =========================================
        -- Pane Swapping
        -- =========================================

        {
            key = "]",
            mods = "LEADER",
            action = act.PaneSelect {
                mode = "SwapWithActiveKeepFocus",
            },
        },

        -- =========================================
        -- Copy Mode
        -- =========================================

        {
            key = "[",
            mods = "LEADER",
            action = act.ActivateCopyMode,
        },

        -- =========================================
        -- Miscellaneous
        -- =========================================

        {
            key = "{",
            mods = "LEADER",
            action = act.PasteFrom("Clipboard"),
        },
        {
            key = "q",
            mods = "CMD",
            action = act.QuitApplication,
        },
        {
            key = "x",
            mods = "LEADER",
            action = act.CloseCurrentPane { confirm = true },
        },
    }

    -- Repeatable leader mappings.
    config.key_tables = {
        manipulate = {
            -- fine resizing
            {
                key = "h",
                action = act.AdjustPaneSize { "Left", 1 },
            },
            {
                key = "j",
                action = act.AdjustPaneSize { "Down", 1 },
            }, {
                key = "k",
                action = act.AdjustPaneSize { "Up", 1 },
            },
            {
                key = "l",
                action = act.AdjustPaneSize { "Right", 1 },
            },

            -- coarse resizing
            {
                key = "H",
                action = act.AdjustPaneSize { "Left", 5 },
            },
            {
                key = "J",
                action = act.AdjustPaneSize { "Down", 5 },
            },
            {
                key = "K",
                action = act.AdjustPaneSize { "Up", 5 },
            },
            {
                key = "L",
                action = act.AdjustPaneSize { "Right", 5 },
            },
        },
    }

    if not is_windows then
        for _, key in ipairs({
            "d", -- half-page down
            "u", -- half-page up
            "o", -- jump last position
            "i", -- jump next position
            "a", -- increment
            "x", -- decrement
            "e", -- nudge down
            "y", -- nudge up
            "r", -- redo
        }) do
            table.insert(config.keys, {
                key = key,
                mods = "CMD",
                action = act.SendKey {
                    key = key,
                    mods = "CTRL",
                }
            })
        end
    end

    if not is_windows then
        for _, key in ipairs({
            { key = "h", code = 72 },
            { key = "l", code = 76 },
        }) do
            table.insert(config.keys, {
                key = key.key,
                mods = "CMD|SHIFT",
                action = act.SendString(
                    string.format("\27[%d;6u", key.code)
                ),
            })
        end
    end
end

return M
