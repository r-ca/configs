local lsp_names = function()
	local clients = {}
	for _, client in ipairs(vim.lsp.get_active_clients { bufnr = 0 }) do
		if client.name == 'null-ls' then
			local sources = {}
			for _, source in ipairs(require('null-ls.sources').get_available(vim.bo.filetype)) do
				table.insert(sources, source.name)
			end
			table.insert(clients, 'null-ls(' .. table.concat(sources, ', ') .. ')')
		else
			table.insert(clients, client.name)
		end
	end
	return ' ' .. table.concat(clients, ', ')
end


return {
	{
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup {
			options = {
				theme = 'nightfly',
				globalstatus = true,
				component_separators = '|',
				section_separators = { left = '', right = '' },
			},
  			sections = {
    				lualine_a = {
     					{ 'mode', separator = { left = '' }, right_padding = 2 },
				},
    				lualine_b = { 'filename', 'branch' },
    				lualine_c = { 'fileformat' },
    				lualine_x = { lsp_names },
    				lualine_y = { 'filetype', 'progress' },
    				lualine_z = {
     					{ 'location', separator = { right = '' }, left_padding = 2 },
    				},
 		 	},
  			inactive_sections = {
    				lualine_a = { 'filename' },
    				lualine_b = {},
 		   		lualine_c = {},
   		 		lualine_x = {},
    				lualine_y = {},
    				lualine_z = { 'location' },
  			},
  			tabline = {},
  			extensions = {},
		}
		end
	}
}
