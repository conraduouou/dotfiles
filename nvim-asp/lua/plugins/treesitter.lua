return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "c_sharp",
      "css",
      "html",
      "javascript",
      "razor",
      "json",
    },
    sync_install = true,
    auto_install = true,
    highlight = { enable = true },
    additional_vim_regex_highlighting = false,
    indent = { enable = true },
  },
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function (_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
