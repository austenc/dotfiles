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
  end,

  -- Key mappings for triggering tests
  keys = {
    { '<Leader>kt', ':w<CR>:TestSuite<CR>' },
    { '<Leader>kf', ':w<CR>:TestFile<CR>' },
    { '<Leader>kp', ':w<CR>:TestLast<CR>' },
    { '<Leader>kr', ':w<CR>:TestNearest<CR>' },
    { '<Leader>kv', ':w<CR>:TestVisit<CR>' },
  },
}
