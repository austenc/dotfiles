return {
    -- {
    'nvim-tree/nvim-tree.lua',
    opts = {
        view = {
            side = 'right'
        }
    },
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.del('n', '<Tab>')
    end,
    -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    -- opts = function()
    -- return require "nvchad.configs.nvimtree"
    -- end,
    -- },
}
