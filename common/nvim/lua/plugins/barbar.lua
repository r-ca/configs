return {
	'romgrk/barbar.nvim',
	dependencies = {
		'lewis6991/gitsigns.nvim',
		'kyazdani42/nvim-web-devicons',
	},
	opts = {

	},
	init = function()
		vim.g.barbar_auto_setup = false
	end
}
