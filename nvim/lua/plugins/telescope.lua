return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'mollerhoj/telescope-recent-files.nvim',
  },
  config = function()
    require("telescope").load_extension("recent-files")
  end,
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
      function()
        require('telescope').extensions['recent-files'].recent_files({})
      end,
      desc = 'Fuzzy File Finder'
    },
    {
      '<leader>[',
      '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>',
      desc = 'Switch Buffer',
    },
  },
}
