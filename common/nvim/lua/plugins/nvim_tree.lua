return {
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		config = function()
			require('nvim-tree').setup({
				update_focused_file = {
					enable = true,
				},
				view = {
					width = 30,
				},
			})
			vim.api.nvim_set_keymap('n', 'f', ':NvimTreeToggle<CR>', { noremap = false, silent = true })
		end
	}
}
