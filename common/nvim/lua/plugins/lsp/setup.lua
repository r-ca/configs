-- Setup LS

local on_attach = function(client, bufnr)

	-- do something
	vim.keymap.set('n', 'an', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'dj', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'rf', '<cmd>lua vim.lsp.buf.formatting()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'F', '<cmd>lua vim.lsp.buf.references()<CR>', { buffer = bufnr })
	vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })

end

local capabilities = require('plugins.lsp.ext.headers').capabilities

return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspconfig = require('lspconfig')
		
		-- Language servers
	
		-- lua
		lspconfig.lua_ls.setup {
			on_attach = on_attach,
			capabilities = capabilities
		}

		-- java
		-- plugins/lsp/lang/java.lua
	
	end
}
