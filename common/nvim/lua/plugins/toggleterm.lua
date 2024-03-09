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
			vim.keymap.set('n', '<A-t>', ':ToggleTerm<CR>')
			vim.keymap.set('t', '<A-t>', '<C-\\><C-n>:ToggleTerm<CR>')
					
        end
    }
}
