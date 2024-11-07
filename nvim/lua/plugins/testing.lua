-- Store the terminal instance globally
local test_term = nil

return {
  'vim-test/vim-test',
  config = function()
    -- Function to create a dedicated floating terminal for tests
    local function run_in_test_term(cmd)
      -- For debugging the command that is being run
      -- print('Test command:', cmd)
      test_term = require('toggleterm.terminal').Terminal:new {
        -- Remove the --colors flag from the command because `artisan test` passes it in already
        cmd = cmd:gsub('%-%-colors', ''),
        display_name = 'Test Runner Output',
        direction = 'float',
        float_opts = {
          border = 'curved',
          width = 120,
          height = 14,
          row = 14,
        },
        close_on_exit = false, -- Keeps the terminal open
        hidden = true,
        on_open = function(term)
          -- Mapping to close the terminal manually
          vim.cmd 'startinsert!'
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        -- Allow us to navigate the terminal output
        on_exit = function(term)
          vim.cmd 'stopinsert'
          vim.g['test#php#phpunit#executable'] = 'php artisan test'
        end,
      }
      test_term:toggle()
    end

    -- Configure vim-test to use this isolated test terminal strategy
    vim.g['test#custom_strategies'] = { floating_term = function(cmd) run_in_test_term(cmd) end }
    vim.g['test#strategy'] = 'floating_term'
    vim.g['test#php#phpunit#executable'] = 'php artisan test'
  end,

  -- Key mappings for triggering tests
  keys = {
    { '<Leader>kz', '<cmd>w<CR><cmd>TestSuite<CR>', desc = 'Run all Tests' },
    { '<Leader>kf', '<cmd>w<CR><cmd>TestFile<CR>', desc = 'Run Tests in File' },
    { '<Leader>kp', '<cmd>w<CR><cmd>TestLast<CR>', desc = 'Run Previous Test' },
    { '<Leader>kr', 'zt<cmd>w<CR><cmd>TestNearest<CR>', desc = 'Run Nearest Test' },
    {
      '<Leader>kt',
      function()
        vim.g['test#php#phpunit#executable'] = 'php artisan test --parallel'
        vim.cmd 'w'
        vim.cmd 'TestSuite'
      end,
      desc = 'Run all Tests (parallel)',
    },
    {
      '<Leader>ko',
      function()
        if test_term then test_term:toggle() end
      end,
      desc = 'View Test Output',
    },
    { '<Leader>kv', '<cmd>w<CR><cmd>TestVisit<CR>', desc = 'Visit (return) to last Test' },
  },
}
