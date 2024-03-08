return {
	'tyru/open-browser.vim',
	config = function()
		vim.keymap.set('n', 'ur', vim.cmd('openbrowser-open'))
	end
}
