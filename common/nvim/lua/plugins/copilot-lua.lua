return {
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup({
				panel = {
					enabled = false,
					-- auto_refresh = true,
					-- keymap = {
						-- TODO: 他のアクションのマップも追加する
					-- 	accept = "<CR>",
					-- },
				},
				suggestion = {
					enabled = false,
					-- auto_trigger = true,
					-- keymap = {
						-- TODO: 他のアクションのマップも追加する
					-- 	accept = "<S-Enter>",
					-- 	dismiss = "<A-Tab>",
					--},
				}
			})
		end
	}
}
