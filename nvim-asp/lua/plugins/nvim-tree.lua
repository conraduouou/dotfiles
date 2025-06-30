return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr)
      vim.api.nvim_set_option_value("fillchars", "eob: ", {})
    end
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- disable netrw at the very start of your project
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local scheduled = function()
      vim.cmd [[
      highlight NvimTreeNormal guibg=NONE ctermbg=NONE
      highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
      highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
      highlight NvimTreeWinSeparator guibg=NONE ctermbg=NONE guifg=#1e2030
      ]]
    end

    vim.schedule(scheduled)
  end,
  version = "*",
  lazy = false,
}
