-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd('BufDelete', {
  group = vim.api.nvim_create_augroup('dashboard_on_empty', {}),
  callback = function(args)
    local deleted_name = vim.api.nvim_buf_get_name(args.buf)
    local deleted_ft = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
    local dashboard_on_empty = (deleted_name == '' and deleted_ft == '')
      or (vim.api.nvim_buf_get_name(0) == '' and vim.api.nvim_get_option_value('filetype', { buf = 0 }) == '')
    if dashboard_on_empty then vim.cmd 'Dashboard' end
  end,
})
