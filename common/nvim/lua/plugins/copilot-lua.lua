return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						-- TODO: 他のアクションのマップも追加する
						accept = "<CR>",
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						-- TODO: 他のアクションのマップも追加する
						accept = "<C-TAB>",
					},
				}
			})
		end
	}
}
