return {
    "conraduouou/vim-tmux-navigator",

    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },

    init = function()
        vim.g.tmux_navigator_no_mappings = 1
    end,

    keys = {
        { "<C-h>", "<cmd>TmuxNavigateLeft<CR>" },
        { "<C-j>", "<cmd>TmuxNavigateDown<CR>" },
        { "<C-k>", "<cmd>TmuxNavigateUp<CR>" },
        { "<C-l>", "<cmd>TmuxNavigateRight<CR>" },
        { "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>" },
    },
}
