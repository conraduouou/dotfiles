return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
  },
  opts = function()
    local cmp = require("cmp")

    return {
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = function ()
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end,
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "buffer" },
        { name = "path" },
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      }
    }
  end,
  lazy = false,
  event = { "BufReadPre", "BufNewFile" }
}
