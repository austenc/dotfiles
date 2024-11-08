-- Taken from
-- https://seankegel.com/neovim-for-php-and-laravel
return {
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { 'pint' },
      },
    },
  },
  {
    -- Add a Treesitter parser for Laravel Blade to provide Blade syntax highlighting.
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'blade',
        'php_only',
      })
    end,
    config = function(_, opts)
      vim.filetype.add {
        pattern = {
          ['.*%.blade%.php'] = 'blade',
        },
      }

      require('nvim-treesitter.configs').setup(opts)
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    opts = function(_, opts)
      local ls = require 'luasnip'
      local s = ls.snippet
      local fmt = require('luasnip.extras.fmt').fmt
      local i = ls.insert_node

      ls.add_snippets('all', {
        -- Auto-pad `{{ ... }}`
        s({ trig = '{{', snippetType = 'autosnippet' }, fmt('{{{{ {} ', { i(0) })),

        -- Auto-pad blade stuff
        s({ trig = '{!', snippetType = 'autosnippet' }, fmt('{{!! {} !!', { i(0) })),
        s({ trig = '{-', snippetType = 'autosnippet' }, fmt('{{{{-- {} --}}', { i(0) })),
        -- Auto-pad antlers stuff
        s({ trig = '{#', snippetType = 'autosnippet' }, fmt('{{{{# {} #}}', { i(0) })),
      })

      -- Enable autosnippets
      ls.setup {
        enable_autosnippets = true,
        store_selection_keys = '<Tab>',
      }

      return opts
    end,
  },
}
