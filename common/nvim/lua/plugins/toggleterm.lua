return {
    {
        'akinsho/nvim-toggleterm.lua',
        config = function()
            require('toggleterm').setup({
                size = 20,
				direction = 'float',
				start_in_insert = true,
				float_opts = {
					border = 'curved',
				}
            })
			vim.keymap.set('n', 'tt', ':ToggleTerm<CR>')
			vim.keymap.set('t', 'Tt', '<C-\\><C-n>:ToggleTerm<CR>')
					
        end
    }
}
