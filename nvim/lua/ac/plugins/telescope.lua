return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
    	{'<Leader>f', function() require('telescope.builtin').git_files() end},
    	{'<Leader>F', function() require('telescope.builtin').find_files() end},
    	{'<Leader>h', function() require('telescope.builtin').oldfiles() end},
    	{'<Leader>H', function() require('telescope.builtin').help_tags() end},
    }
 }
