return {
  'nvim-telescope/telescope.nvim',
  config = {
    defaults = {
      sorting_strategy = 'ascending',
      layout_config = {
        prompt_position = 'top',
      },
    },
  },
  keys = {
    {
      '<Leader>?',
      function() require('telescope.builtin').help_tags() end,
      desc = 'Help',
    },
    {
      '<Leader>fk',
      function() require('telescope.builtin').keymaps() end,
      desc = 'Keyboard Shortcuts',
    },
    {
      '<leader>p',
      '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>',
      desc = 'Switch Buffer',
    },
  },
}
