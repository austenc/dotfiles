-- Set initial vim options
require('ac.keymaps')
require('ac.options')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy.nvim
require('lazy').setup('ac.plugins', {
    ui = {
        border = 'rounded'
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
})


-- Theming
-- Enable true color support
vim.o.termguicolors = true
-- vim.cmd('colorscheme natty')
