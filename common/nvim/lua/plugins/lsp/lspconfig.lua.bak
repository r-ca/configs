local on_attach = function(client, bufnr)

	-- do something
	vim.keymap.set('n', 'an', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'dj', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'rf', '<cmd>lua vim.lsp.buf.formatting()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'F', '<cmd>lua vim.lsp.buf.references()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })

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
		require('mason-lspconfig').setup_handlers {
			function(server_name)
				require('lspconfig')[server_name].setup {
					on_attach = on_attach,
					capabilities = capabilities,
				}
			end,
		}
		
		--require('mason-lspconfig').setup_handlers {
		--	["jdtls"] = function()
		--		require('lspconfig').jdtls.setup {
		--			on_attach = on_attach,
		--			capabilities = capabilities,
		--		}
		--	end,		
		--}


	end
}
