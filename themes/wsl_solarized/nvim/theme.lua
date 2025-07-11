-- local lsp_config = require("lspconfig")
-- lsp_config.lua_ls.setup({
-- 	settings = {
-- 		Lua = {
-- 			hint = {
-- 				enable = true,
-- 			},
-- 			runtime = {
-- 				version = "LuaJIT",
-- 			},
-- 			workspace = {
-- 				checkThirdParty = true,
-- 				library = {
-- 					vim.env.VIMRUNTIME,
-- 					"~/.local/share/nvim/lazy/solarized.nvim",
-- 				},
-- 			},
-- 		},
-- 	},
-- })

return {
	{
		"maxmx03/solarized.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = {
				enabled = false,
				pmenu = true,
				normal = true,
				normalfloat = true,
				neotree = true,
				nvimtree = true,
				whichkey = true,
				telescope = true,
				lazy = true,
			},
			on_highlights = nil,
			on_colors = nil,
			palette = "solarized", -- solarized (default) | selenized
			variant = "autumn", -- "spring" | "summer" | "autumn" | "winter" (default)
			error_lens = {
				text = false,
				symbol = false,
			},
			styles = {
				enabled = true,
				types = {},
				functions = {},
				parameters = {},
				comments = {},
				strings = {},
				keywords = {},
				variables = {},
				constants = {},
			},
			plugins = {
				treesitter = true,
				lspconfig = true,
				navic = true,
				cmp = true,
				indentblankline = true,
				neotree = true,
				nvimtree = true,
				whichkey = true,
				dashboard = true,
				gitsigns = true,
				telescope = true,
				noice = true,
				hop = true,
				ministatusline = true,
				minitabline = true,
				ministarter = true,
				minicursorword = true,
				notify = true,
				rainbowdelimiters = true,
				bufferline = true,
				lazy = true,
				rendermarkdown = true,
				ale = true,
				coc = true,
				leap = true,
				alpha = true,
				yanky = true,
				gitgutter = true,
				mason = true,
				flash = true,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "solarized",
			},
		},
	},
}
