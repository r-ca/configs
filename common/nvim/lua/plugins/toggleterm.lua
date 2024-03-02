return {
    {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require('toggleterm').setup({
                size = 20,
            })
        end
    }
}
