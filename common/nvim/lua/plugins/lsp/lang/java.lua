return {
	'mfussenegger/nvim-jdtls',
	dependencies = {
		'neovim/nvim-lspconfig'
	},
	ft = { "java" },
	config = function()
    local share_dir = os.getenv("HOME") .. "/.local/share"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = share_dir .. "/eclipse/" .. project_name

    local java_bin = function()
	    local java_home = os.getenv('JAVA_HOME')
	    if java_home then
		    return java_home .. '/bin/java'
	    else
		    return 'java'
	    end
    end

    local mason_registry = require("mason-registry")

    local jdtls_path = mason_registry.get_package('jdtls'):get_install_path()

    java_binary = java_bin()

    local on_attach = function(client, bufnr)
	    require('plugins.lsp.ext.handlers').on_attach(client, bufnr)
    end

    local capabilities = require('plugins.lsp.ext.handlers').capabilities
    local extended_capabilities = require('jdtls').extendedClientCapabilities
    extended_capabilities.resolveAdditionalTextEditsSupport = true

        local config = {

	autostart = true,


    -- org.eclipse.equinox.launcher_*.jar を読みこむ
    launcher_path = vim.fn.globpath(jdtls_path, 'org.eclipse.equinox.launcher_*.jar')[1],

	filetypes = { 'java' },

	cmd = {
		java_binary,

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx16g',
		-- '-javaagent:' .. jdtls_path .. '/lombok.jar',
		'-javaagent:/home/rca/configs/common/nvim/libs/lombok-edge-1.18.31.jar',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar', jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
		'-configuration', jdtls_path .. '/config_linux',
		'-data', workspace_dir,
	},

	capabilities = capabilities,

	-- extendedClientCapabilities = extended_capabilities,

	on_attach = on_attach,

	root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),

	flags = {
		-- debounce_text_changes = 150,
		allow_incremental_sync = true,
	},

	single_file_support	= true,
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true
			},
			contentProvider = {
				preferred = 'fernflower'
			},
			signatureHelp = { enabled = true },
			references = {
				includeDecompiledSources = true,
			},
			completion = {
            	favoriteStaticMembers = {
            		"org.hamcrest.MatcherAssert.assertThat",
            		"org.hamcrest.Matchers.*",
            		"org.hamcrest.CoreMatchers.*",
            		"org.junit.jupiter.api.Assertions.*",
            		"java.util.Objects.requireNonNull",
            		"java.util.Objects.requireNonNullElse",
            		"org.mockito.Mockito.*"
            	}
			},
			configuration = {
				updateBuildConfiguration = 'interactive',
			},
			maven = {
				downloadSources= true
			},
			inlayHints = {
				parameterNames = {
					enabled = 'all'
				}
			},
			extendedClientCapabilities = extended_capabilities,
			sources = {
				organizeImports = {
					-- onSave = true,
					starThreshold = 9999,
					staticStarThreshold = 9999
				}
			}
		}
	}
}
		-- Add language server attach auto cmd
		vim.api.nvim_create_augroup('java-ls', { clear = true })
		vim.api.nvim_create_autocmd(
			{ 'FileType' },
			{
				pattern = 'java',
				group = 'java-ls',
				callback = function()
					require('jdtls').start_or_attach(config)
				end
			}
		)

		-- Init and attach
		require('jdtls').start_or_attach(config)
	end
}
