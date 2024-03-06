return {
	'williamboman/mason-lspconfig.nvim',
	dependencies = {
		{'williamboman/mason.nvim'},
		{'neovim/nvim-lspconfig'},
		{'hrsh7th/nvim-cmp'},
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/vim-vsnip'},
		{'hrsh7th/cmp-vsnip'},
		{'onsails/lspkind-nvim'},
	},
	config = function()
		local capabilities = require('cmp_nvim_cmp').default_capabilities()

		require('mason').setup()
		require('mason-lsnconfig').setup()
		require('mason-lspconfig').setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					capabilities = capabilities,
				}
			end,
		}
	end
}
