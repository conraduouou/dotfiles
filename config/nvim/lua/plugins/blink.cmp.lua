return {
    'saghen/blink.cmp',

    -- use a release tag to download pre-built binaries
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        sources = {
            default = {
                "lsp",
                "path",
                "snippets",
                "buffer",
                "ripgrep",

                "lazydev",
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
                ripgrep = {
                    name = "Ripgrep",
                    module = "blink-ripgrep",
                    opts = {},
                },
            },
        },

        keymap = {
            preset = 'none',

            ['<Enter>'] = { 'accept', 'fallback' },
            ['<Esc>'] =   { 'hide', 'fallback' },
            ['<Tab>'] =   { 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<C-,>'] =   {
                function (cmp)
                    if not cmp.is_active() then return cmp.show() end

                    if cmp.is_documentation_visible() then
                       return cmp.hide_documentation()
                    else
                        return cmp.show_documentation()
                    end
                end,
            },

            ['<C-j>'] =   { 'select_next', 'fallback' },
            ['<C-k>'] =   { 'select_prev', 'fallback' },
            ['<C-e>'] =   { 'scroll_documentation_down', 'fallback' },
            ['<C-y>'] =   { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] =   {
                function (cmp)
                    if cmp.is_documentation_visible() then
                        return cmp.scroll_documentation_down(5)
                    end
                end
            },
            ['<C-u>'] =   {
                function (cmp)
                    if cmp.is_documentation_visible() then
                        return cmp.scroll_documentation_up(5)
                    end
                end
            },
        },

        cmdline = {
            keymap = {
                preset = 'none',

                ['<Tab>'] = { 'show_and_insert_or_accept_single', 'select_next' },
                ['<S-Tab>'] = { 'show_and_insert_or_accept_single', 'select_prev' },

                ['<C-,>'] = { 'show', 'hide' },

                ['<C-j>'] = { 'select_next', 'fallback' },
                ['<C-k>'] = { 'select_prev', 'fallback' },
            }


        }
    },

    opts_extend = { "sources.default" }
}
