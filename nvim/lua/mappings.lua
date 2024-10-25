require 'nvchad.mappings'

local map = vim.keymap.set
local unmap = vim.keymap.del

-- Cleanup / Unmappings
-------------------------------------------------------------------------------
-- <leader>w
unmap('n', '<leader>wk') -- whichkey search
unmap('n', '<leader>wK') -- whichkey full keymap
-- These don't work because they must not be registered yet
-- unmap('n', '<leader>wl') -- LSP list workspace folders
-- unmap('n', '<leader>wa') -- LSP add workspace folder
-- unmap('n', '<leader>wr') -- LSP remove workspace folder

-- Save file with Ctrl+S -- remap Cmd+S to Ctrl+S in iterm with "send vim text \<C-s> (with prefix slash)"
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")


-- Sidebar
-------------------------------------------------------------------------------
-- Toggle file tree on and off
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })
-- Unmap tab and shift tab from the file tree
-- TODO: This doesn't work

-- Window management
-------------------------------------------------------------------------------
-- map('n', '<leader>wv', function()
--     vim.cmd.vsplit()
--     vim.cmd.enew()
--     vim.cmd.Dashboard() -- TODO: This doesn't work
-- end, { silent = true, desc = 'window vertical split with dashboard' })
map('n', '<leader>wv', vim.cmd.vsplit, { silent = true, desc = 'window vertical split' }) -- Vertical split
map('n', '<leader>wh', vim.cmd.hsplit, { silent = true, desc = 'window horizontal split' }) -- Horizontal split
map('n', '<Leader>O', '<C-w>o', { desc = 'window maximize' }) -- Maximize Make window only window
map('n', '<Tab>', '<C-w>w') -- Cycle to next window
map('n', '<S-Tab>', '<C-w>W') -- Cycle to previous window
-- Remap ctrl+i to be separate from Tab, so we can use with ctrl+o
map('n', '<C-i>', '<C-i>', { silent = true })
-- Swap between previously active file
map('n', '<Leader>p', '<c-^>', { desc = 'swap to previous file' })


-- Editing
-------------------------------------------------------------------------------
-- Semicolon and comma at the end of lines
map('i', ';;', '<Esc>A;<Esc>')
map('i', ',,', '<Esc>A,<Esc>')
-- Move lines up and down with alt + j and k
map('n', '<A-j>', ':m .+1<CR>==', { silent = true, desc = 'move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { silent = true, desc = 'move line up' })
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { silent = true, desc = 'move line down' })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { silent = true, desc = 'move line up' })
map('v', '<A-j>', ':m \'>+1<CR>gv=gv', { silent = true, desc = 'move line down' })
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', { silent = true, desc = 'move line up' })
-- Jesse's big idea 💡 indent entire file correctly
map('n', '<Leader>=', 'ggVG=', { desc = 'autoindent entire file' })
-- Keep visual selection when indenting
map('x', '>', '>gv')
map('x', '<', '<gv')
-- Break undo sequence on specific characters thanks to @jesseleite
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', '!', '!<C-g>u')
map('i', '?', '?<C-g>u')


-- Configuration & Settings
-------------------------------------------------------------------------------
-- Settings
map('n', '<leader>,t', function()
    require('nvchad.themes').open()
end, { desc = 'telescope nvchad themes' })
map('n', '<leader>,k', '<cmd>WhichKey <CR>', { desc = 'keyboard shortcuts' })
map('n', '<leader>,K', function()
    vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'search key bindings' })
-- Toggleable settings
map('n', '<leader>,i', '<cmd>IBLToggle<CR>', { desc = 'toggle indentation guides' })

-- Telescope
-------------------------------------------------------------------------------
-- Keybinding search via Telescope
map('n', '<leader>fk', function()
    require('telescope.builtin').keymaps()
end, { desc = 'telescope keymaps' })
-- Search commands via Telescope
map('n', '<leader>fc', function()
    require('telescope.builtin').commands()
end, { desc = 'telescope commands' })
-- Search help via Telescope
map('n', '<leader>?', function()
    require('telescope.builtin').help_tags()
end, { desc = 'telescope help' })


-- Terminal
-------------------------------------------------------------------------------
map({ 'n', 't' }, '<leader>t', function()
    require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
end, { desc = 'toggle terminal' })
map({ 'n', 't' }, '<leader>T', function()
    require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' }
end, { desc = 'toggle terminal floating' })
