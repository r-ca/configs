return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = 'dir_up' },
            },
        },
      },
      filters = {
        dotfiles = true,
      },
    }
  }
}
