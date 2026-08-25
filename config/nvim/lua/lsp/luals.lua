vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})

vim.lsp.enable("lua_ls")
