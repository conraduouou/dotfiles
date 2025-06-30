return {
  "windwp/nvim-ts-autotag",
  ft = {
    "html",
    "javascript",
  },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
