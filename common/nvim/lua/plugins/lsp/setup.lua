-- Setup LS
local on_attach = function(client, bufnr)
	require('plugins.lsp.ext.handlers').on_attach(client, bufnr)
	-- global additionals
	-- do something
end

local capabilities = require('plugins.lsp.ext.handlers').capabilities

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
