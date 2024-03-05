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
        { import = "plugins" }
    }
})

-- Colorscheme
vim.cmd[[colorscheme catppuccin]]
-- vim.cmd[[colorscheme tokyonight-day]]

-- Config
local opt = vim.opt

opt.autoindent = true -- Auto indent
opt.smartindent = true -- Smart indent

opt.cursorline = true -- Highlight current line
opt.number = true -- Show line numbers

opt.tabstop = 4 -- Tab width
opt.shiftwidth = 4 -- Indent width
opt.expandtab = false -- Use spaces instead of tabs

opt.laststatus = 3

-- Keymaps
vim.keymap.set('i', 'ii', '<cmd>:stopinsert<CR>')

vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')

vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')

vim.keymap.set('n', 'J', ':AnyJump<CR>')
vim.keymap.set('n', 'K', ':AnyJumpBack<CR>')

-- LazyGit
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap('n', 'gg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
