return {
  'vim-test/vim-test',
  config = function()
    -- Function to create a dedicated floating terminal for tests
    local function run_in_test_term(cmd)
      local test_term = require('toggleterm.terminal').Terminal:new {
        cmd = cmd,
        direction = 'float',
        float_opts = {
          border = 'curved',
          width = 120,
          height = 14,
        },
        close_on_exit = false, -- Keeps the terminal open
        hidden = true,
        on_open = function(term)
          -- Map Escape to close the terminal manually
          vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Esc>', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
      }
      test_term:toggle()
    end

    -- Configure vim-test to use this isolated test terminal strategy
    vim.g['test#custom_strategies'] = { floating_term = function(cmd) run_in_test_term(cmd) end }
    vim.g['test#strategy'] = 'floating_term'
    vim.g['test#php#phpunit#executable'] = 'php artisan test' -- Adjust the path if necessary
  end,

  -- Key mappings for triggering tests
  keys = {
    { '<Leader>kt', ':w<CR><cmd>TestSuite<CR>', desc = 'Run all Tests' },
    { '<Leader>kf', ':w<CR><cmd>TestFile<CR>', desc = 'Run Tests in File' },
    { '<Leader>kp', ':w<CR><cmd>TestLast<CR>', desc = 'Run Previous Test' },
    { '<Leader>kr', ':w<CR><cmd>TestNearest<CR>', desc = 'Run Nearest Test' },
    -- { '<Leader>kv', ':w<CR>:TestVisit<CR>', desc = 'Run Visit Test??' },
  },
}
