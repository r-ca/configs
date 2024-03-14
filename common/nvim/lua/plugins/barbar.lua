return {
	'romgrk/barbar.nvim',
	dependencies = {
		'lewis6991/gitsigns.nvim',
		'kyazdani42/nvim-web-devicons',
	},
	opts = {
		animation = true,
		icons = {
			-- buffer_index = true,
			-- buffer_number = true,
		},
		gitsigns = {
			added = {
				enabled = true,
				icon = '+'
			},
			changed = {
				enabled = true,
				icon = '~'
			},
			deleted = {
				enabled = true,
				icon = '-'
			},
		},
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end
}
