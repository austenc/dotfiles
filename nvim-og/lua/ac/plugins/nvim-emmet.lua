return {
    'olrtg/nvim-emmet',
    keys = {
        { '<Leader>ww', function() require('nvim-emmet').wrap_with_abbreviation() end, mode = { 'n', 'v' } },
    },
}
