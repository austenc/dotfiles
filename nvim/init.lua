-- UI (needs to be before lazy setup)
 vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

-- Keymaps and Config
require('ac.keymaps')
require('ac.options')

-- 📦 Lazy.nvim
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

-- Lazy.nvim Initialization
require('lazy').setup('ac.plugins', {
    ui = {
        border = 'rounded'
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

-- Load all base46 themes (needs to be after lazy setup)
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end
