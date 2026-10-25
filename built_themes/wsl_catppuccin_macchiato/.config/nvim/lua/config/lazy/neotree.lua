return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		opts = {
			window = {
				mappings = {
					-- ["e"] = "move_cursor_up",
					['<C-e>'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
					['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
					['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
				},
			},
			filesystem = {
				window = {
					mappings = {
						["e"] = "move_cursor_up",
					},
					fuzzy_finder_mappings = {
						["<down>"] = "move_cursor_down",
						["<C-n>"] = "move_cursor_down",
						["<up>"] = "move_cursor_up",
						["<C-p>"] = "move_cursor_up",
						["Esc"] = "close",
						["<S-CR>"] = "close_keep_filter",
						["<C-CR>"] = "close_clear_filter",
						["<C-w>"] = { "<C-S-w>", raw = true },
						{
							n = {
								["n"] = "move_cursor_down",
								["e"] = "move_cursor_up",
								["<S-CR>"] = "close_keep_filter",
								["<C-CR>"] = "close_clear_filter",
							},
						},
					},
				},
			},
		},
	},
}
