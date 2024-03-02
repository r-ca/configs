return {
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		keys = {
			{ "<leader>f", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
			{ "F", "<cmd>NvimTreeFindFile<CR>", desc = "Find file in tree" },
		},
		opts = {
			view = {
				adaptive_size = true,
			},
			filters = {
				dotfiles = true,
			},
		},
	}
}
