return {
    "Pocco81/auto-save.nvim",
    config = function()
        require("auto-save").setup({
            enabled = true,
            events = { "InsertLeave", "TextChanged" },
            conditions = {
                exists = true,
                filetype_is_not = {},
                modifiable = true,
            },
            write_all_buffers = false,
            on_off_commands = true,
        })
    end,
}
