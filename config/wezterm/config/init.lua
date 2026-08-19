local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("config.general").apply(config)
require("config.visuals").apply(config)
require("config.mappings").apply(config)

return config
