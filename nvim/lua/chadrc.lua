-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme = 'jabuti',
    transparency = true,

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
}

M.nvdash = {
    load_on_startup = true,
    header = {
        '                                                          ',
        '    ██╗   ██╗███████╗     ██████╗ ██████╗ ██████╗ ███████╗',
        '    ██║   ██║██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝',
        '    ██║   ██║███████╗    ██║     ██║   ██║██║  ██║█████╗  ',
        '    ╚██╗ ██╔╝╚════██║    ██║     ██║   ██║██║  ██║██╔══╝  ',
        '     ╚████╔╝ ███████║    ╚██████╗╚██████╔╝██████╔╝███████╗',
        '      ╚═══╝  ╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝',
        '                                                          ',
        '                   Like Neovim, but better!               ',
        '                                                          ',
    },
    buttons = {
        { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
        { txt = "  Find Files", keys = "ff", cmd = "Telescope find_files" },
        { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
        { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
        { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashLazy",
        no_gap = true,
      },

      { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
    },
}

M.term = {
    float = {
        width = 0.9,
        height = 0.3,
        col = 0.035,
        row = 0.3,
    },
}

M.ui = {
    statusline = {
        theme = 'vscode_colored',
    },
}

return M
