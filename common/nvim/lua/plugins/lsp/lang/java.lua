
share_dir = os.getenv("HOME") .. "/.local/share"
project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
workspace_dir = share_dir .. "/eclipse/" .. project_name

java_bin = function()
	local java_home = os.getenv('JAVA_HOME')
	if java_home then
		return java_home .. '/bin/java'
	else
		return 'java'
	end
end

mason_registry = require("mason-registry")

jdtls_path = mason_registry.get_package('jdtls'):get_install_path()

local config = {
	cmd = { 
		java_bin(),		
		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',
		'-Xmx1g',
		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		'-jar',
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		'-configuration',
		vim.fn.glob(jdtls_path .. "/config_linux"),
		'-data',
		workspace_dir,
	},
		
	root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
	settings = {
		java = {
			signatureHelp = { enabled = true },

		}
	}
}

return {
	'mfussenegger/nvim-jdtls',
	config = function()
		require('jdtls').start_or_attach(config)
	end
}
