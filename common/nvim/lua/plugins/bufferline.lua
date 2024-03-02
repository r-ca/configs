return {
    {
        'akinsho/nvim-bufferline.lua',
        config = function()
            require('bufferline').setup {
                options = {
                    numbers = 'ordinal',
                    close_command = 'bdelete! %d',
                    right_mouse_command = 'bdelete! %d',
                    middle_mouse_command = 'bdelete! %d',
                    offsets = {
                        {
                            filetype = 'NvimTree',
                            text = 'File Explorer',
                            highlight = 'Directory',
                            text_align = 'left'
                        }
                    }
                }
            }
        end
    }
}
