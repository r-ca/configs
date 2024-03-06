return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		{'hrsh7th/cmp-nvim-lsp'},
		{'hrsh7th/cmp-buffer'},
		{'hrsh7th/cmp-path'},
		{'hrsh7th/vim-vsnip'},
		{'hrsh7th/cmp-vsnip'},
		{'onsails/lspkind-nvim'},
	},
	config = function()
		require('cmp').setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},

			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'buffer' },
				{ name = 'path' },
				{ name = 'vsnip' },
			},
			
			formatting = {
				format = require('lspkind').cmp_format({with_text = true, maxwidth = 50})
			},

			-- WIP(Copilotのサジェストそのままなのでいつかなおす)
			mapping = {
    			['<Tab>'] = cmp.mapping(function(fallback)
      				if cmp.visible() then
        				cmp.select_next_item()
      				else
        				fallback()
					end
    			end, { 'i' }),
    			['<S-Tab>'] = function(fallback)
      				if cmp.visible() then
        				cmp.select_prev_item()
      				else
        				fallback()
      				end
    			end,
				['<C-n>'] = require('cmp').mapping.select_next_item(),
				['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
				['<C-f>'] = require('cmp').mapping.scroll_docs(4),
				['<C-Space>'] = require('cmp').mapping.complete(),
				['<C-e>'] = require('cmp').mapping.close(),
				['<CR>'] = require('cmp').mapping.confirm({
					behavior = require('cmp').ConfirmBehavior.Insert,
					select = true,
				}),
			},
		})
	end
}
