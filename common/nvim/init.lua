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

-- Keymaps
vim.api.nvim_set_keymap('i', 'ee', vim.cmd("stopinsert"), { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'ee', vim.cmd("startinsert"), { noremap = true, silent = true })
