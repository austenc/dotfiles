require 'nvchad.mappings'

local map = vim.keymap.set

-- Wish we could have this, but it breaks repeat / next with f and t
-- map("n", ";", ":", { desc = "CMD enter command mode" })

map('i', 'jk', '<ESC>')

-- Toggle file tree on and off
map('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Window management
-- Vertical split
-- map('n', '<Leader>v', vim.cmd.vsplit, { silent = true }, desc = 'vertical split')

-- Cycle through windows
map('n', '<Tab>', '<C-w>w')
-- map('n', '<S-Tab>', '<C-w>W')

-- Remap ctrl+i to be separate from Tab, so we can use with ctrl+o
map('n', '<C-i>', '<C-i>', { silent = true })

-- Make window only window
map('n', '<Leader>O', '<C-w>o', { desc = 'maximize window' })

-- Swap between previously active file
map('n', '<Leader>p', '<c-^>', { desc = 'swap to previous file' })

-- Jesse's big idea 💡
map('n', '<Leader>=', 'ggVG=', { desc = 'autoindent entire file' })

-- Semicolon and comma at the end of lines
map('i', ';;', '<Esc>A;<Esc>')
map('i', ',,', '<Esc>A,<Esc>')

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
