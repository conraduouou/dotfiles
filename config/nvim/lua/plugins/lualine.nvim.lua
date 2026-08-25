return {
    'nvim-lualine/lualine.nvim',

    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },

    opts = {
        options = {
            component_separators = '',
            section_separators = '',
            globalstatus = true,
            disabled_filetypes = {
                statusline = { 'dashboard', 'alpha', 'starter' },
            },
            theme = 'auto',
        },

        sections = {
            -- Left side: workspace / buffers
            lualine_a = {
                {
                    'buffers',
                    mode = 2,
                    symbols = {
                        modified = ' ●',
                        alternate_file = '',
                        directory = '',
                    },
                    buffers_color = {
                        active = 'TabLineSel',
                        inactive = 'TabLine',
                    },
                },
            },

            lualine_b = {},
            lualine_c = {},

            -- Right side: file information
            lualine_x = {
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = {
                        error = '󰅚 ',
                        warn = '󰀪 ',
                        info = '󰋽 ',
                        hint = '󰌶 ',
                    },
                },
                {
                    'filetype',
                    icon_only = true,
                },
            },

            lualine_y = {
                {
                    'branch',
                    icon = '',
                    color = 'TabLine',
                },
                {
                    'diff',
                    color = 'TabLine',
                },
            },

            lualine_z = {
                {
                    'progress',
                    color = 'StatusLine',
                    separator = '',
                },
                {
                    'location',
                    color = 'StatusLine',
                    separator = { left = ' ', right = '' },
                },
            },
        },
    },
}
