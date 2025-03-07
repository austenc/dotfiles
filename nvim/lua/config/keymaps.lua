-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Unmap some of the default keymaps for LazyVim
-------------------------------------------------------------------------------
unmap('n', '<leader>,')
unmap('n', '<leader>K')
unmap('n', '<leader>l')
unmap('n', '<leader>L')
-- Diagnostics/Quickfix defaults from LazyVim
unmap('n', '<leader>xl')
unmap('n', '<leader>xL')
unmap('n', '<leader>xq')
unmap('n', '<leader>xQ')
unmap('n', '<leader>xx')
unmap('n', '<leader>xX')
-- unmap('n', '<leader>xt')
-- unmap('n', '<leader>xT')
-- Have to unmap this because for some reason toggleterm is mapping this to insert mode
-- even though it says it only maps the open_mapping setting in normal mode 🤷
unmap('i', '<leader>t')

-- AI tools
-------------------------------------------------------------------------------
map('n', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
map('v', '<C-a>', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
map('n', '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
map('v', '<leader>at', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
map('v', '<leader>ac', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
map('n', '<leader><leader>', '<cmd>CodeCompanion<cr>', { noremap = true, silent = true })

-- Window Management
-------------------------------------------------------------------------------
map('n', '<Tab>', '<C-w>w') -- Cycle to next window
map('n', '<S-Tab>', '<C-w>W') -- Cycle to previous window
map('n', '<leader>x', LazyVim.ui.bufremove, { desc = 'Delete Buffer' })

-- Editing
-------------------------------------------------------------------------------
-- Save file with Ctrl+S -- remap Cmd+S to Ctrl+S in iterm with "send vim text \<C-s> (with prefix slash)"
map({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<cr>')
-- Format file with conform
map('n', '<leader>;', function() require('conform').format { lsp_fallback = true } end, { desc = 'Format file' })

-- Semicolon and comma at the end of lines
map('i', ';;', '<Esc>A;<Esc>')
map('i', ',,', '<Esc>A,<Esc>')
-- Move lines up and down with alt + j and k
map('n', '<A-j>', ':m .+1<CR>==', { silent = true, desc = 'move line down' })
map('n', '<A-k>', ':m .-2<CR>==', { silent = true, desc = 'move line up' })
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { silent = true, desc = 'move line down' })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { silent = true, desc = 'move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true, desc = 'move line down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true, desc = 'move line up' })
-- Jesse's big idea 💡 indent entire file correctly
map('n', '<Leader>=', 'ggVG=', { desc = 'Fix Indentation' })
-- Keep visual selection when indenting
map('x', '>', '>gv')
map('x', '<', '<gv')
-- Break undo sequence on specific characters thanks to @jesseleite
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', '!', '!<C-g>u')
map('i', '?', '?<C-g>u')
map('n', '<leader>ff', ':Telescope file_browser path=%:p:h select_buffer=true<CR>')

-- Configuration & Settings
-------------------------------------------------------------------------------
-- Settings
map('n', '<leader>,k', '<cmd>WhichKey <CR>', { desc = 'keyboard shortcuts' })
map('n', '<leader>,K', function() vim.cmd('WhichKey ' .. vim.fn.input 'Search Keys: ') end, { desc = 'Search Keymap' })
-- Toggleable settings
map('n', '<leader>,i', '<cmd>IBLToggle<CR>', { desc = 'toggle indentation guides' })
map('n', '<leader>,n', '<cmd>set rnu!<CR>', { desc = 'toggle line numbers' })
map(
  'n',
  '<leader>,v',
  [[:lua _G.exclude_vendor_in_search = not _G.exclude_vendor_in_search<CR>]],
  { desc = 'Toggle vendor files', noremap = true, silent = true }
)

-- Terminal
-------------------------------------------------------------------------------
map('t', '<esc>', [[<C-\><C-n>]])
map('t', 'jk', [[<C-\><C-n>]])
map('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
map('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
map('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
map('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
map('t', '<C-w>', [[<C-d>]])

---
