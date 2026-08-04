return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.scroll = { enabled = false }

    opts.picker = opts.picker or {}

    -- configure the picker keymaps
    opts.picker.win = opts.picker.win or {}
    opts.picker.win.input = opts.picker.win.input or {}
    opts.picker.win.input.keys = opts.picker.win.input.keys or {}

    -- remap navigation in the input window
    opts.picker.win.input.keys["<A-j>"] = { "list_down", mode = { "n", "i" } }
    opts.picker.win.input.keys["<A-k>"] = { "list_up", mode = { "n", "i" } }

    -- remap half‑page scrolling
    opts.picker.win.input.keys["<A-d>"] = { "list_scroll_down", mode = { "n", "i" } }
    opts.picker.win.input.keys["<A-u>"] = { "list_scroll_up", mode = { "n", "i" } }
    opts.picker.win.input.keys["<C-d>"] = { "inspect", mode = { "n", "i" } }

    return opts
  end,
}
