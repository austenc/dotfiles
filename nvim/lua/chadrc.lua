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
