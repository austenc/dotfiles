return {
  'folke/todo-comments.nvim',
  keys = {
    { ']t', function() require('todo-comments').jump_next() end, desc = 'Next Todo Comment' },
    { '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous Todo Comment' },
    { '<leader>xt', false },
    { '<leader>xT', false },
    -- { '<leader>,t', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
    -- {
    --   '<leader>,T',
    --   '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>',
    --   desc = 'Todo/Fix/Fixme (Trouble)',
    -- },
    { '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
    { '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
  },
}
