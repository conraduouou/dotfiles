return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "json",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
}
