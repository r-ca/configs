return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/vim-vsnip'},
		{'hrsh7th/cmp-vsnip'},
		{'onsails/lspkind-nvim'},
		{'zbirenbaum/copilot-cmp'}
	},
	config = function()
		require('cmp').setup({
			snippet = {
				expand = function(args)
					vim.fn['vsnip#anonymous'](args.body)
				end,
			},

			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'buffer' },
				{ name = 'path' },
				{ name = 'vsnip' },
				{ name = 'copilot' },
			},
			
			formatting = {
				format = require('lspkind').cmp_format({with_text = true, maxwidth = 50})
			},

			-- WIP(Copilotのサジェストそのままなのでいつかなおす)
			mapping = {
    			['<Tab>'] = require('cmp').mapping(function(fallback)
      				if require('cmp').visible() then
        				require('cmp').select_next_item()
      				else
        				fallback()
					end
    			end, { 'i' }),
    			['<S-Tab>'] = function(fallback)
      				if require('cmp').visible() then
        				require('cmp').select_prev_item()
      				else
        				fallback()
      				end
    			end,
				['<C-n>'] = require('cmp').mapping.select_next_item(),
				['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
				['<C-f>'] = require('cmp').mapping.scroll_docs(4),
				['<C-e>'] = require('cmp').mapping.close(),
				['<CR>'] = require('cmp').mapping.confirm({
					behavior = require('cmp').ConfirmBehavior.Insert,
					select = true,
				}),
			},
		})
	end
}
