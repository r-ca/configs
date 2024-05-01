return {
    'indeedhat/nvim-kragle',
    config = function()
        vim.keymap.set('n', 'wa', ':call kragle#AdoptBuffer()', { noremap = true, silent = true }) -- Adopt
        vim.keymap.set('n', 'wo', ':call kragle#OrpahBuffer()', { noremap = true, silent = true }) -- Orphah
        vim.keymap.set('n', 'wfi', ':call kragle#FocusRemote()', { noremap = true, silent = true }) -- FocusRemote
        vim.keymap.set('n', 'wfb', ':call kragle#SwitchToBuffer()', { noremap = true, silent = true }) -- SwitchToBuffer
    end,
}
