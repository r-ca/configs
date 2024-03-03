return {
	{
		'github/copilot.vim',
		lazy = false,
		config = function()
			require('github-copilot').setup({
				vim.keymap.set('i', '<S-TAB>', 'copilot#Accept("<CR>")', { silent = true, expr = true }),
			})
		end
	}
}
