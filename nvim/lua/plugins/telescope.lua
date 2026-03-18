return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = function(_, opts)
    local actions = require("telescope.actions")

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      mappings = {
        i = {
          ["<A-j>"] = actions.move_selection_next,
          ["<A-k>"] = actions.move_selection_previous,
          ["<A-d>"] = actions.preview_scrolling_down,
          ["<A-u>"] = actions.preview_scrolling_up,
        },
      },
    })
    return opts
  end,
}
