-- Use spacebar as Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Window management
-- Vertical split
vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit, { silent = true })

-- Cycle through windows
vim.keymap.set('n', '<Tab>', '<C-w>w')
vim.keymap.set('n', '<S-Tab>', '<C-w>W')

-- Make window only window
vim.keymap.set('n', '<Leader>O', '<C-w>o')

-- Swap between previously active file
vim.keymap.set('n', '<Leader>p', '<c-^>')

-- Jesse's big idea 💡
vim.keymap.set('n', '<Leader>=', 'ggVG=')

