return {
	-- {
	-- 	"AlphaTechnolog/pywal.nvim",
	-- 	priority = 1000,
	-- },

    {
        "sainnhe/gruvbox-material",
        priority = 1000, -- Ensure it loads first
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_background = 'dark'

        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = 'gruvbox-material'
            }
        }
    },
}
