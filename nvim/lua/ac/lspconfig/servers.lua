-------------------------------------------------------------------------------
-- Configured Lsp Servers
--------------------------------------------------------------------------------

return {
    intelephense = true,
    html = {
        filetypes = { 'html', 'blade', 'antlers' },
    },
    antlersls = true,
    tailwindcss = true,
    jsonls = true,
    yamlls = true,
    lua_ls = true,
    emmet_language_server = {
        filetypes = { "css", "html", "javascript", "blade", "svelte", "php"},
    },
}
