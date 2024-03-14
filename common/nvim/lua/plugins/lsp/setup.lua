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
			autostart = true,
			on_attach = on_attach,
			capabilities = capabilities
		}

		-- Vue
		-- lspconfig.vuels.setup{
		-- 	autostart = true,
		-- 	on_attach = on_attach,
		-- 	capabilities = capabilities
		-- }

        -- Vue3
        lspconfig.volar.setup{
            autostart = true,
            on_attach = on_attach,
            capabilities = capabilities
        }

		-- CSS
		lspconfig.cssls.setup{
			autostart = true,
			on_attach = on_attach,
			capabilities = capabilities
		}

		-- TS/JS
		lspconfig.configs.vtsls = require('vtsls').lspconfig
		lspconfig.vtsls.setup({})

		-- Python
		lspconfig.pylsp.setup{
			-- autostart = true,
			-- on_attach = on_attach,
			-- capabilities = capabilities
		}

		-- lspconfig.pyright.setup{
			-- autostart = true,
			-- on_attach = on_attach,
			-- capabilities = capabilities
		-- }
		
		-- Bash
		lspconfig.bashls.setup{
			autostart = true,
			on_attach = on_attach,
			capabilities = capabilities
		}

        -- PHP
        lspconfig.phpactor.setup{
            autostart = true,
            on_attach = on_attach,
            capabilities = capabilities
        }

        lspconfig.tsserver.setup{
            autostart = true,
            on_attach = on_attach,
            capabilities = capabilities
        }
    end
}
