return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        {'<Leader>f', function() require('telescope.builtin').git_files() end},
        {'<Leader>F', function() require('telescope.builtin').find_files() end},
        {'<Leader>h', function() require('telescope.builtin').oldfiles() end},
        {'<Leader>H', function() require('telescope.builtin').help_tags() end},
    },
    config = function ()
        local telescope = require('telescope')
        telescope.setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                },
                file_ignore_patterns = {
                    'node_modules',
                    '.DS_Store',
                    '.git/',
                    'resources/dist',
                    'storage/framework',
                },
            },
            pickers = {
                find_files = {
                    prompt_title = 'All Files',
                    no_ignore = true,
                    hidden = true,
                },
            },
        })
        telescope.load_extension('fzf')
    end,
}
