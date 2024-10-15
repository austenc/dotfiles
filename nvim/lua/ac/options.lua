-- Default to four spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- use system clipboard by default 
vim.opt.clipboard = 'unnamed'

-- Theming
-- Enable true color support
vim.o.termguicolors = true
-- vim.cmd('colorscheme natty')

-- Ensure only one status line globally
-- vim.opt.laststatus = 3

-- Ensure there's only one status line across all windows
vim.opt.laststatus = 3

-- Hide the command line unless it's needed
-- Some day we can enable this... but it's too buggy for now.
-- vim.opt.cmdheight = 0
