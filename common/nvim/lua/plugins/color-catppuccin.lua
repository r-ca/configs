return {
	'catppuccin/nvim',
	name = 'catpuccin',
	lazy = false,
	priotity = 1000,
	config = function() 
		require('catppuccin').setup({
			flavour = 'latte'
		})
	end
}

	

