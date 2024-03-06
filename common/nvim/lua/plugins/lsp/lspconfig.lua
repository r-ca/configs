local on_attach = function(client, bufnr)

	-- do something

end

return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
		{'williamboman/mason.nvim'},
		{'neovim/nvim-lspconfig'},
	},
	config = function()
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		require('mason').setup()
		require('mason-lspconfig').setup()
		require('mason-lspconfig').setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					on_attach = on_attach,
					capabilities = capabilities,
				}
			end,
		}
	end
}
