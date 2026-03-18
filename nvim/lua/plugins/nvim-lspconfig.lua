return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    -- Lua
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = { diagnostics = { globals = { "vim" } } },
      },
    })
    vim.lsp.enable("lua_ls")

    -- Python
    vim.lsp.config("pyright", {})
    vim.lsp.enable("pyright")

    -- TypeScript/JavaScript
    vim.lsp.config("tsserver", {})
    vim.lsp.enable("tsserver")
  end,
}
