require("nvim-tree").setup({
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
})
