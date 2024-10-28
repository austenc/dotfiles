return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = 'helix',
  },
  keys = {
    {
      "<leader>,wk",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
