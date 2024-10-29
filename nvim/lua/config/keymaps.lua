-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Unmap some of the default keymaps for LazyVim
-------------------------------------------------------------------------------
unmap("n", "<leader>,")

-- Window Management
-------------------------------------------------------------------------------
map("n", "<Tab>", "<C-w>w") -- Cycle to next window
map("n", "<S-Tab>", "<C-w>W") -- Cycle to previous window

-- Editing
-------------------------------------------------------------------------------
-- Save file with Ctrl+S -- remap Cmd+S to Ctrl+S in iterm with "send vim text \<C-s> (with prefix slash)"
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")
-- Format file with conform
map("n", "<leader>;", function()
require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- Semicolon and comma at the end of lines
map("i", ";;", "<Esc>A;<Esc>")
map("i", ",,", "<Esc>A,<Esc>")
-- Move lines up and down with alt + j and k
map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "move line up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "move line up" })
-- Jesse's big idea 💡 indent entire file correctly
map("n", "<Leader>=", "ggVG=", { desc = "autoindent entire file" })
-- Keep visual selection when indenting
map("x", ">", ">gv")
map("x", "<", "<gv")
-- Break undo sequence on specific characters thanks to @jesseleite
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", "!", "!<C-g>u")
map("i", "?", "?<C-g>u")

-- Configuration & Settings
-------------------------------------------------------------------------------
-- Settings
map("n", "<leader>,k", "<cmd>WhichKey <CR>", { desc = "keyboard shortcuts" })
map("n", "<leader>,K", function()
  vim.cmd("WhichKey " .. vim.fn.input("Search Keys: "))
end, { desc = "Search Keymap" })
-- Toggleable settings
map("n", "<leader>,i", "<cmd>IBLToggle<CR>", { desc = "toggle indentation guides" })
map("n", "<leader>,n", "<cmd>set rnu!<CR>", { desc = "toggle line numbers" })
