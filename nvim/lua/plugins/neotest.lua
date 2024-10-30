return {
  'nvim-neotest/neotest',
  dependencies = {
    'olimorris/neotest-phpunit',
  },
  opts = {
    adapters = {
      require 'neotest-phpunit',
    },
    keys = {
      { '<leader>kf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = 'Run File' },
      { '<leader>kt', function() require('neotest').run.run(vim.uv.cwd()) end, desc = 'Run All Test Files' },
      { '<leader>kr', function() require('neotest').run.run() end, desc = 'Run Nearest' },
      { '<leader>kp', function() require('neotest').run.run_last() end, desc = 'Run Last' },
      { '<leader>kw', function() require('neotest').watch.toggle(vim.fn.expand '%') end, desc = 'Toggle Watch' },
      -- Not sure what rest of these do yet
      { '<leader>kks', function() require('neotest').summary.toggle() end, desc = 'Toggle Summary' },
      {
        '<leader>kko',
        function() require('neotest').output.open { enter = true, auto_close = true } end,
        desc = 'Show Output',
      },
      { '<leader>kkO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle Output Panel' },
      { '<leader>kkS', function() require('neotest').run.stop() end, desc = 'Stop' },
    },
  },
}
