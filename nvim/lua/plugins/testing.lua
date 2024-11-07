return {
  'vim-test/vim-test',
  config = function()
    -- Function to create a dedicated floating terminal for tests
    local function run_in_test_term(cmd)
      -- For debugging the command that is being run
      -- print('Test command:', cmd)
      local test_term = require('toggleterm.terminal').Terminal:new {
        -- Remove the --colors flag from the command because `artisan test` passes it in already
        cmd = cmd:gsub('%-%-colors', ''),
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
        on_exit = function(term) vim.cmd 'stopinsert' end,
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
    { '<Leader>kt', '<cmd>w<CR><cmd>TestSuite<CR>', desc = 'Run all Tests' },
    { '<Leader>kf', '<cmd>w<CR><cmd>TestFile<CR>', desc = 'Run Tests in File' },
    { '<Leader>kp', '<cmd>w<CR><cmd>TestLast<CR>', desc = 'Run Previous Test' },
    { '<Leader>kr', 'zt<cmd>w<CR><cmd>TestNearest<CR>', desc = 'Run Nearest Test' },
    -- { '<Leader>kv', ':w<CR>:TestVisit<CR>', desc = 'Run Visit Test??' },
  },
}
