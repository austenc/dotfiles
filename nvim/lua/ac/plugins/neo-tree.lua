return {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- For file icons
        'MunifTanjim/nui.nvim',
    },
    keys = {
        {
            '<Leader>e',
            function()
                require('neo-tree.command').execute({ toggle = true, dir = vim.uv.cwd() })
            end,
            desc = 'Toggle File Tree',
        }
    },
    config = function()
        require('neo-tree').setup({
            close_if_last_window = true,
            popup_border_style = 'rounded',
            sort_case_insensitive = true,
            sources = { 'filesystem', 'buffers', 'git_status' },
            -- default_component_configs = {
            --     icon = {
            --         folder_closed = '',
            --         folder_open = '',
            --         folder_empty = '',
            --         default = '*',
            --     },
            --     git_status = {
            --         symbols = {
            --             added     = '✚',
            --             modified  = '',
            --             deleted   = '✖',
            --             renamed   = '',
            --             untracked = '¤',
            --         },
            --     },
            -- },
            window = {
                position = 'right', -- Place the sidebar on the right
                width = 40,
            },
            filesystem = {
                visible = true,
                follow_current_file = true,
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        })
    end,
}







