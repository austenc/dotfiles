require 'nvchad.mappings'

local map = vim.keymap.set

-- Toggle file tree on and off
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")


-- Window management
-- ----------------------------------------------------------------------------
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
-- ----------------------------------------------------------------------------
-- Semicolon and comma at the end of lines
map('i', ';;', '<Esc>A;<Esc>')
map('i', ',,', '<Esc>A,<Esc>')

-- Move lines up and down with alt + j and k
map('n', '<A-j>', '<Esc>:m .+1<CR>==', { desc = 'move line down' })
map('n', '<A-k>', '<Esc>:m .-2<CR>==', { desc = 'move line up' })

-- Jesse's big idea 💡 indent entire file correctly
map('n', '<Leader>=', 'ggVG=', { desc = 'autoindent entire file' })


-- Configuration & Settings
-- ----------------------------------------------------------------------------
-- Settings mapped to <leader>, combos
map('n', '<leader>,t', function()
    require('nvchad.themes').open()
end, { desc = 'telescope nvchad themes' })
map('n', '<leader>,k', '<cmd>WhichKey <CR>', { desc = 'keyboard shortcuts' })
map('n', '<leader>,K', function()
    vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'search key bindings' })

-- Toggle terminal
map({ 'n', 't' }, '<leader>t', function()
    require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
end, { desc = 'toggle terminal' })

-- Telescope Keybindings
map('n', '<leader>fk', function()
    require('telescope.builtin').keymaps()
end, { desc = 'telescope keymaps' })
