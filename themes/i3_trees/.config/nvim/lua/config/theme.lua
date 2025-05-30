return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "buffer_id", -- or "buffer_id" for buffer numbers
					close_command = "bdelete! %d",
					right_mouse_command = "bdelete! %d",
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
						},
					},
					separator_style = "slant", -- or "thin" for a minimal look
					show_buffer_close_icons = true,
					show_close_icon = false,
					diagnostics = "nvim_lsp",
				},
			})
		end,
	},
	{
		"neanias/everforest-nvim",
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "hard",
				italics = true,
				ui_contrast = "high",
				dim_inactive_windows = true,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("lualine").setup({
				options = {
					theme = "everforest",
					globalstatus = true,
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
			})
		end,
	},
}