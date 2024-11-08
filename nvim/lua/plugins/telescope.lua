_G.exclude_vendor_in_search = true

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'mollerhoj/telescope-recent-files.nvim',
  },
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
        require('telescope').extensions['recent-files'].recent_files {
          hidden = true,
          no_ignore = true,
          file_ignore_patterns = {
            'node_modules/',
            'build/',
            'dist/',
            exclude_vendor_in_search and 'vendor/' or nil, -- Conditionally include 'vendor/'
            '%.git/',
            'storage/',
            '%.DS_Store',
            '%.phpunit.result.cache',
          },
        }
      end,
      desc = 'Fuzzy File Finder',
    },

    {
      '<leader>[',
      '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>',
      desc = 'Switch Buffer',
    },
  },
}
