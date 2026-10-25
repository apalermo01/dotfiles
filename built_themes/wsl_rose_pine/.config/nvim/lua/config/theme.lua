return {

    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = 'moon',
            dim_inactive_windows = true,

            styles = {
                transparency = true
            }
        }
    },
    {
        'akinsho/bufferline.nvim',
        event = 'ColorScheme',
        config = function()
            local highlights = require('rose-pine.plugins.bufferline')
            require('bufferline').setup({ highlights = highlights })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        config = function()
            require('lualine').setup({
                options = {
                    --- @usage 'rose-pine' | 'rose-pine-alt'
                    theme = 'rose-pine'
                }
            })
        end
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            require('notify').setup({
                background_colour = "#000000"
            })
        end
    }
}
