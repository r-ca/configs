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

-- TODO: Fix this
local jdtls_path = '/home/rca/.local/share/nvim/mason/packages/jdtls'
-- jdtls_path = mason_registry.get_package('jdtls'):get_install_path()

local java_binary = '/usr/lib/jvm/java-21-openjdk/bin/java'
-- java_binary = java_bin()

local on_attach = function(client, bufnr)
	require('plugins.lsp.ext.handlers').on_attach(client, bufnr)
end

local capabilities = require('plugins.lsp.ext.handlers').capabilities

local config = {

	cmd = {
		java_binary,

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'-javaagent:' .. jdtls_path .. '/lombok.jar',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
		'-jar', jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar',
		'-configuration', jdtls_path .. '/config_linux',
		'-data', workspace_dir,
	},

	capabilities = capabilities,

	on_attach = on_attach,

	root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),

	single_file_support	= true,
	settings = {
		java = {
			signatureHelp = { enabled = true },

		}
	}
}

return {
	'mfussenegger/nvim-jdtls',
	ft = {'java'},
	config = function()
		require('jdtls').start_or_attach(config)
	end
}
