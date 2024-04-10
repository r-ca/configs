return {
	'rmagatti/goto-preview',
	config = function()
		require('goto-preview').setup{}
		vim.keymap.set('n', '<S-p>d', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
		vim.keymap.set('n', '<S-p>t', "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
		vim.keymap.set('n', '<S-p>d', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
		vim.keymap.set('n', '<S-p>i', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
		vim.keymap.set('n', '<S-p>r', "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
		vim.keymap.set('n', '<S-p>c', "<cmd>lua require('goto-preview').close_all_win()<CR>")
	end
}
