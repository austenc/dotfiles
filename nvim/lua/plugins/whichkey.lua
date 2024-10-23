return {
  'folke/which-key.nvim',
  opts = {
    delay = function (ctx)
      return ctx.plugin and 0 or 1000
    end
  }
}
