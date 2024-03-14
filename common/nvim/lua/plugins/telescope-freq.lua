return {
  "nvim-telescope/telescope-frecency.nvim",
  config = function()
    require("telescope").load_extension "frecency"
	vim.keymap.set('n', '<C-S-f>', ':Telescope frecency<CR>')
  end,
}
