-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- require("lazy").setup({
--     spec = {
--         { import = "plugins" },
--         { import = "plugins.java" }
--     }
-- })

require("lazy").setup({
    spec = {
        { import = "plugins" },
		{ import = "plugins.lsp" },
		{ import = "plugins.lsp.lang" },
    }
})

vim.diagnostic.config({
	underline = true,
	signs = true,
	update_in_insert = true,
})

-- lsp
--require('plugins.lsp.lang.java')
-- Colorscheme
vim.cmd[[colorscheme catppuccin]]
-- vim.cmd[[colorscheme tokyonight-day]]

-- Config
local opt = vim.opt

opt.autoindent = true -- Auto indent
opt.smartindent = true -- Smart indent

opt.cursorline = true -- Highlight current line
opt.number = true -- Show line numbers
opt.numberwidth = 5 -- Line number width

opt.tabstop = 4 -- Tab width
opt.shiftwidth = 4 -- Indent width
opt.expandtab = false -- Use spaces instead of tabs

opt.laststatus = 3

-- Keymaps
-- Back to normal
vim.keymap.set('i', 'ii', '<cmd>:stopinsert<CR>')
vim.keymap.set('t', 'ii', '<C-\\><C-n>')
vim.keymap.set('v', 'ii', '<Esc>')

-- Window navigation
-- in normal
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')

-- in terminal
vim.keymap.set('t', '<C-h>', '<C-\\><C-N>:wincmd h<CR>')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N>:wincmd l<CR>')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N>:wincmd j<CR>')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N>:wincmd k<CR>')

-- Cursor navigation (Insert)
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')

-- AnyJump
vim.keymap.set('n', 'J', ':AnyJump<CR>')
vim.keymap.set('n', 'K', ':AnyJumpBack<CR>')

-- Tab navigation
-- in normal
-- vim.keymap.set('n', '<C-S-p>', '<cmd>tabNext<CR>', { noremap = false })
-- vim.keymap.set('n', '<C-S-o>', '<cmd>tabprevious<CR>', { noremap = false })
--
-- -- in insert
-- vim.keymap.set('i', '<C-S-p>', '<cmd>tabNext<CR>', { noremap = false })
-- vim.keymap.set('i', '<C-S-o>', '<cmd>tabprevious<CR>', { noremap = false })
--
-- -- in terminal
-- vim.keymap.set('t', '<C-S-p>', '<C-\\><C-N>:tabNext<CR>', { noremap = false })
-- vim.keymap.set('t', '<C-S-o>', '<C-\\><C-N>:tabprevious<CR>', { noremap = false })
--
-- -- in command
-- vim.keymap.set('c', '<C-S-p>', '<C-\\><C-N>:tabNext<CR>', { noremap = false })
-- vim.keymap.set('c', '<C-S-o>', '<C-\\><C-N>:tabprevious<CR>', { noremap = false })
--
-- -- Tab manage
-- vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { noremap = false })
-- vim.keymap.set('n', '<C-w>', ':tabclose<CR>', { noremap = false })
--
-- misc
vim.keymap.set('i', '<S-BS>', '<C-w>')

-- LazyGit
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap('n', 'gg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

local group = vim.api.nvim_create_augroup("jump_last_position", { clear = true })
vim.api.nvim_create_autocmd(
	"BufReadPost",
	{callback = function()
			local row, col = unpack(vim.api.nvim_buf_get_mark(0, "\""))
			if {row, col} ~= {0, 0} then
				vim.api.nvim_win_set_cursor(0, {row, 0})
			end
		end,
	group = group
	}
)
