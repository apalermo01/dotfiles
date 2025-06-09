return {
	"folke/which-key.nvim",
	lazy = false,
	opts = {
		preset = "helix", -- classic | modern | helix
		keys = { -- scroll bindings inside the popup
			scroll_down = "<C-d>",
			scroll_up = "<C-u>",
		},

		-- v3 mapping spec
		spec = {
			------------------------------------------------------------------
			-- <space> …  (leader in the helix preset)
			------------------------------------------------------------------
			{ "b", group = "Buffers" }, -- <space>b
			{ "t", group = "Tabs" }, -- <space>t
			{ "v", group = "LSP" }, -- <space>v
			{ "d", group = "Debug" }, -- <space>d
			{ "p", group = "Pickers" }, -- <space>p
			{ "c", group = "Code" }, -- <space>c
			{ "g", group = "Git" }, -- <space>g
			{ "h", group = "Harpoon" }, -- <space>h
			{ "o", group = "Obsidian" }, -- <space>o

			------------------------------------------------------------------
			-- <space><space>… (double-leader)
			------------------------------------------------------------------
			{ "<Space>t", group = "Terminal" }, -- <space><space>t
		},
	},
}