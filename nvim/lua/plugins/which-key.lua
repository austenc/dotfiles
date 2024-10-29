return {
  'folke/which-key.nvim',
  opts = {
    preset = 'modern',
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>,', group = 'Settings', icon = { icon = '', color = 'green' } },
        { '<leader>x', group = 'Close File', icon = { icon = '󰱝 ', color = 'green' } },
      },
    },
    icons = {
      group = '',
    },
  },
  keys = {
    { '<leader>?', false },
  },
}
