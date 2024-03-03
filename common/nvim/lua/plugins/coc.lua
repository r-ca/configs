-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

return {
	{
		'neoclide/coc.nvim',
		branch = 'release',
		config = function()
			vim.keymap.set('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "Space" : coc#refresh()', { silent = true, expr = true }) -- Use <C-Space> to trigger completion.
			-- +Shift = back
			vim.keymap.set('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { silent = true, expr = true }) -- Use <C-Space> to trigger completion.	
			vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { silent = true, expr = true })
		end
	}
}
