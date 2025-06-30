return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
    },
  },
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  lazy = false,
  event = { "BufReadPre", "BufNewFile" }
}
