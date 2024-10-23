return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'makhttps://github.com/jesseleite/dotfiles/blob/master/nvim/after/ftplugin/help.luae' },
    },
    keys = {
        {'<Leader>f', function() require('telescope.builtin').git_files() end},
        {'<M-p>', function() require('telescope.builtin').git_files() end}, -- for Hyper terminal Cmd+P
        {'<Leader>F', function() require('telescope.builtin').find_files() end},
        {'<Leader>h', function() require('telescope.builtin').oldfiles({ cwd_only = true }) end},
        {'<Leader>H', function() require('telescope.builtin').oldfiles({ cwd_only = true }) end},
        {'<Leader>?', function() require('telescope.builtin').help_tags() end},
        {'<Leader>k', function() require('telescope.builtin').keymaps() end},
    },
    cmd = { 'Telescope' },
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
