vim.lsp.config("powershell_es", {
    filetypes = { 'ps1' },
    bundle_path = vim.lsp.config.powershell_es.bundle_path .. "/PowerShellEditorServices",
})
