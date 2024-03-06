local config = {
	cmd = { '/home/rca/.local/share/nvim/mason/bin/jdtls' },
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
