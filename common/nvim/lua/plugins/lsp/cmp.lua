return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/vim-vsnip'},
		{'hrsh7th/cmp-vsnip'},
		{'onsails/lspkind-nvim'},
	},
	config = function()
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
