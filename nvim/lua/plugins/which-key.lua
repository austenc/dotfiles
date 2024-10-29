return {
  'folke/which-key.nvim',
  opts = {
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>x', group = 'Close File', icon = { icon = '󰱝 ', color = 'green' } },
      },
    },
  },
}
