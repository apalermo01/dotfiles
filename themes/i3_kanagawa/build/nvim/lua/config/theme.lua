return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			-- transparent = true,
			dimInactive = true,
			terminalColors = true,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		after = "kanagawa",
		opts = {
			options = {
			    theme = "kanagawa",
				icons_enabled = true,
				globalstatus = true,
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "dashboard", "lazy", "alpha" },
			},
		},
	},
}
