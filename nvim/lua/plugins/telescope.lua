return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  tag = "0.1.8",
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("ui-select")
  end
}
