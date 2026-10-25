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
            -- event_handlers = {
            --     {
            --         envent = "neo_tree_buffer_enter",
            --         handler = function(arg)
            --             vim.opt_local.relativenumber = true
            --         end,
            --     }
            -- },
            close_if_last_window = true,
			window = {
				mappings = {
					-- ["e"] = "move_cursor_up",
					['f'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
					['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
					['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
				},
			},
            -- buffers = {
            --     window = {
            --         mappings = {
            --             ["e"] = "move_cursor_up",
            --             ["n"] = "move_cursor_down"
            --         },
            --     },
            -- },
            -- git_status = {
            --     window = {
            --         mappings = {
            --             ["e"] = "move_cursor_up",
            --             ["n"] = "move_cursor_down"
            --         },
            --     },
            -- },
			filesystem = {
				window = {
					mappings = {
						["e"] = "move_cursor_up",
						["n"] = "move_cursor_down",
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
