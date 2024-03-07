
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

-- jdtls_path = mason_registry.get_package('jdtls'):get_install_path()

-- TODO: Fix this
jdtls_path = '/home/rca/.local/share/nvim/mason/packages/jdtls'

jdtls_bin = '/home/rca/.local/share/nvim/mason/bin/jdtls'

-- java_binary = java_bin()
java_binary = '/usr/lib/jvm/java-21-openjdk/bin/java'

on_attach = function(client, bufnr)
	require('plugins.lsp.ext.handlers').on_attach(client, bufnr)
end

capabilities = require('plugins.lsp.ext.handlers').capabilities

local config = {
	--cmd = {
	--	jdtls_bin,
	--	[[--jvm-arg="-javaagent:/home/rca/configs/common/nvim/libs/lombok-1.18.30.jar"]],
		--"\"-javaagent=" .. jdtls_path .. "/lombok.jar\"",
		--"\"-javaagent=/home/rca/.local/share/nvim/mason/packages/jdtls/lombok.jar\"",
		--'\'-javaagent:/home/rca/configs/common/nvim/libs/lombok-1.18.30.jar\'',
	--	"-data", workspace_dir,
		--"-configuration", jdtls_path .. "/config_linux",
	--	"-configuration", "/home/rca/.local/share/nvim/mason/packages/jdtls/config_linux",
	--},
	
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

	--init_options = {
		--jvm_args = {
		--	'-javaagent=/home/rca/.local/share/nvim/mason/packages/jdtls/lombok.jar',
		--},
		-- workspace = workspace_dir,
	--},

	capabilities = capabilities,

	on_attach = on_attach,
	--root_dir = {
        -- Single-module projects
    --    {
    --      'build.xml', -- Ant
    --      'pom.xml', -- Maven
    --      'settings.gradle', -- Gradle
    --      'settings.gradle.kts', -- Gradle
    --    },
        -- Multi-module projects
      --  { 'build.gradle', 'build.gradle.kts' },
      --} or vim.fn.getcwd(),

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
