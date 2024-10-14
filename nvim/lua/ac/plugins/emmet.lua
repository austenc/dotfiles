--------------------------------------------------------------------------------
-- Emmet: Quickly write html and css by expanding abbreviations
--------------------------------------------------------------------------------

return {
    'mattn/emmet-vim',
    enabled = false,
    keys = {
        { '<C-e>', '<plug>(emmet-expand-abbr)', mode = 'i' },
        { ']e', '<plug>(emmet-move-next)' },
        { '[e', '<plug>(emmet-move-prev)' },
        { '<C-i>t', '<plug>(emmet-update-tag)' },
        { '<C-i>w', '<C-i>,', mode = 'x', remap = true },
        -- { '<C-i>i', '<plug>(emmet-balance-tag-inward)' },
    },
    lazy = false,
    init = function ()
        vim.g.user_emmet_leader_key = '<C-i>'
    end,
}
