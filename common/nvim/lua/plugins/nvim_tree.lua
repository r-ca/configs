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
				on_attach = function(bufnr)
					local api = require 'nvim-tree.api'
					api.config.mappings.default_on_attach(bufnr)
					vim.keymap.del('n', 'f', { buffer = bufnr })
					vim.keymap.set('n', '<Space>', api.node.open.edit, { buffer = bufnr })
				end
			})
			vim.api.nvim_set_keymap('n', 'f', ':NvimTreeToggle<CR>', { noremap = false, silent = true })
		end
	}
}
