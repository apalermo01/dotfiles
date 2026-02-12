return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-live-grep-args.nvim" },
		config = function()
			local telescope = require("telescope")

			-- first setup telescope
			telescope.setup({
				defaults = {
					initial_mode = "normal",
					dynamic_preview_title = true,
				},
			})

			-- then load the extension
			telescope.load_extension("live_grep_args")
		end,
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"xiyaowong/telescope-emoji.nvim",
	},
}
