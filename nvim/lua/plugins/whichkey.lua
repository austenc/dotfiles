return {
  'folke/which-key.nvim',
  opts = {
    preset = 'modern',
    icons = {
      rules = {
        { pattern = 'keyboard', icon = '⌨', color = 'blue' },
      },
    },
  --   delay = function (ctx)
  --     return ctx.plugin and 0 or 1000
  --   end
  }
}
