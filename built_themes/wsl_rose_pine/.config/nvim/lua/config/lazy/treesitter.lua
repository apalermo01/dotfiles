return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function() 
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"bash",
				"c",
				"css",
				"html",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"go",
				"git_config",
				"gitcommit",
				"git_rebase",
				"gitignore",
				"gitattributes",
				"vim",
				"vimdoc",
				"comment",
				"diff",
				"dockerfile",
				"json",
				"jsonc",
				"rasi",
				"regex",
				"requirements",
				"sql",
                "nix"
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true
			}, 
			indent = { enable = true }
		})
	end
}
