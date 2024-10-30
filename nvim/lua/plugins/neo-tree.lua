return {
  'nvim-neo-tree/neo-tree.nvim',
  enabled = true,
  opts = {
    window = {
      position = 'right',
    },
    close_if_last_window = true,
    sort_case_insensitive = true,
    filesystem = {
      visible = true,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = true,
        hide_gitignored = true,
        always_show = {
          '.prettierrc',
          '.github',
        },
        always_show_by_pattern = {
          '.env*',
          'core*',
        },
      },
    },
  },
}
