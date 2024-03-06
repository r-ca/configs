
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

capabilities = require('plugins.lsp.ext.handlers').capabilities

local config = {
	cmd = {
		jdtls_bin,
		"-data", workspace_dir,
		"-configuration", jdtls_path .. "/config_linux",
	},

	init_options = {
		workspace = workspace_dir,
	},

	capabilities = capabilities,

	root_dir = {
        -- Single-module projects
        {
          'build.xml', -- Ant
          'pom.xml', -- Maven
          'settings.gradle', -- Gradle
          'settings.gradle.kts', -- Gradle
        },
        -- Multi-module projects
        { 'build.gradle', 'build.gradle.kts' },
      } or vim.fn.getcwd(),

	single_file_support	= true,
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
