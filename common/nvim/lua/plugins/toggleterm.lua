return {
    {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require('toggleterm').setup({
                size = 20,
            })
			vim.keymap.set('n', 'tr', ':ToggleTerm<CR>')
        end
    }
}
