return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup({})
			vim.keymap.set('i', '<C-TAB>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
		end
	}
}
