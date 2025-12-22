return {
	"stevearc/oil.nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
	lazy = false,

	opts = {
		default_file_explorer = false,
		keymaps = {
			["<C-s>"] = { "actions.select", opts = { horizontal = true } },
			["<C-v>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = false,
			["<C-l>"] = false,
		},

		win_options = {
			winbar = "%!v:lua.get_oil_winbar()",
		},

		view_options = {

            -- show hidden files only if we're in dotfiles repo,
            -- in the config folder, or if there are github actions
			show_hidden = function()
				local current_file = vim.fn.expand("%:p")

				return string.find(current_file, "git/dotfiles/", 1, true)
					or string.find(current_file, ".config", 1, true)
					or vim.fn.isdirectory(
                        vim.fn.getcwd() .. "/.github"
                    ) == 1
			end,
			preview_win = {},
		},
	},
}
