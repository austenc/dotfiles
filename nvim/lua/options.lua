require "nvchad.options"

-- add yours here!

local opt = vim.opt
-- opt.cursorlineopt ='both' -- to enable cursorline!

-- Default to four spaces
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = 'number'

-- use system clipboard by default
opt.clipboard = 'unnamed'

-- Theming
-- Enable true color support
vim.o.termguicolors = true
