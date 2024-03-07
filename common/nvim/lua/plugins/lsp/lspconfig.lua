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
		-- Setup Java
		-- require('plugins.lsp.ext.java')

		local capabilities = require('plugins.lsp.ext.handlers').capabilities

		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = {
			--	"jdtls",
			},
		})
		--require('mason-lspconfig').setup_handlers {
		--	function(server_name)
		--		require('lspconfig')[server_name].setup {
		--			-- on_attach = on_attach,
		--			capabilities = capabilities,
		--		}
		--	end,
		--}
		--
		require('mason-lspconfig').setup_handlers {
			["jdtls"] = function()
				require('lspconfig').jdtls.setup {
					on_attach = on_attach,
					capabilities = capabilities,
				}
			end,		
		}


	end
}
