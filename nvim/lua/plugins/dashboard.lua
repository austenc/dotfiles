local logo = "\n"
  .. [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠴⡶⡐⡄⡀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⣫⡛⣮⠸⡨⡪⡑⢆
⢀⡠⣄⠀⠀⠀⠀⠀⣠⢲⢵⣝⢬⣏⠾⡘⣌⢎⢜⢅
⠪⣎⢎⡳⣢⣀⣠⢞⣜⢗⡵⡳⠕⠁⠀⡪⡢⡱⡊⡆
⠀⠈⠪⡳⡱⣎⢼⡱⢏⠞⠁⠀⠀⠀⠀⡪⡪⡸⢌⢎
⠀⢀⡴⣹⢎⡞⢦⡫⣫⢖⣄⠀⠀⠀⠀⡕⡜⢜⢢⠣
⢴⢯⡺⣕⠏⠉⠘⢮⢪⢮⣪⢫⢦⡀⠀⡎⣪⠱⡱⡑
⠀⠙⠊⠀⠀⠀⠀⠀⠑⢣⡳⣹⢪⡝⣳⠸⡔⢝⢌⢇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠳⣕⢝⡮⡪⡪⡱⡱⠑
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠱⠝⠬⠊⠈⠀   { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
        },⠀
]]
  .. "\n⚡️🧙  VS Code Has No Power Here!"

return {
  "nvimdev/dashboard-nvim",
  config = {
    config = {
      header = vim.split(logo, "\n"),
      center = {
        {
          action = 'lua LazyVim.pick("oldfiles")()',
          desc = " Recent Files",
          icon = " ",
          key = "r",
        },
        {
          action = "lua LazyVim.pick()()",
          desc = " Find File",
          icon = " ",
          key = "f",
        },
        {
          action = 'lua LazyVim.pick("live_grep")()',
          desc = " Find Text",
          icon = " ",
          key = "g",
        },
        {
          action = "lua LazyVim.pick.config_files()()",
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          action = 'lua require("persistence").load()',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
      },
    },
  },
}
