-- Lazy.nvim - The Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- if vim.g.vscode then
    -- Make Shift + Arrow keys work with Visual mode as normal selections
    vim.keymap.set('n', '<S-Up>', 'v<Up>', { remap = false, silent = true })
    vim.keymap.set('x', '<S-Up>', '<Up>', { remap = false, silent = true })
    vim.keymap.set('n', '<S-Down>', 'v<Down>', { remap = false, silent = true })
    vim.keymap.set('x', '<S-Down>', '<Down>', { remap = false, silent = true })
    vim.keymap.set('n', '<S-Left>', 'v<Left>', { remap = false, silent = true })
    vim.keymap.set('x', '<S-Left>', '<Left>', { remap = false, silent = true })
    vim.keymap.set('n', '<S-Right>', 'v<Right>', { remap = false, silent = true })
    vim.keymap.set('x', '<S-Right>', '<Right>', { remap = false, silent = true })

-- end

-- Normal Neovim config
