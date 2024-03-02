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

-- Config
local opt = vim.opt

opt.autoindent = true -- Auto indent
opt.smartindent = true -- Smart indent

opt.cursorline = true -- Highlight current line
opt.number = true -- Show line numbers

opt.tabstop = 2 -- Tab width
opt.shiftwidth = 2 -- Indent width
opt.expandtab = false -- Use spaces instead of tabs

-- Keymaps
vim.keymap.set('i', 'ii', '<cmd>:stopinsert<CR>')

vim.keymap.set('n', '<C-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>')

vim.keymap.set('n', 'J', ':AnyJump<CR>')
vim.keymap.set('n', 'K', ':AnyJumpBack<CR>')

-- LazyGit
local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap('n', 'lg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
