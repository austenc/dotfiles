return {
  'folke/which-key.nvim',
  opts = {
    preset = 'modern',
    spec = {
      {
        mode = { 'n', 'v' },
        { '<leader>,', group = 'settings', icon = { icon = '', color = 'green' } },
        { '<leader>x', group = 'Close File', icon = { icon = '󰱝 ', color = 'green' } },
      },
    },
    icons = {
      group = '',
      rules = {
        { pattern = 'fix indentation', icon = '' },
        { pattern = 'format file', icon = '🧹' },
      },
    },
  },
  keys = {
    { '<leader>?', false },
  },
}
