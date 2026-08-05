return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "python", "javascript", "typescript", "dart" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
