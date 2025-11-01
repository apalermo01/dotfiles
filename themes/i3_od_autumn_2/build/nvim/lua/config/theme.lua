return {
	{
		"AlphaTechnolog/pywal.nvim",
		priority = 1000,
	},

    -- {
    --     "olimorris/onedarkpro.nvim",
    --     priority = 1000, -- Ensure it loads first
    --     opts = {
    --         options = {
    --             highlight_inactive_windows = false
    --         }
    --     }
    -- },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = 'pywal-nvim'
            }
        }
    },
}
