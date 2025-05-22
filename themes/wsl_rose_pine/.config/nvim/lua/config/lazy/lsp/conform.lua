-- formatting

map("n", "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			nix = { "nixfmt" },
			-- sql = { "sqlfmt" },
            -- sql = { "sql-formatter" },
            sql = { "pg_format" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			sh = { "shfmt" },
			md = { "mdformat" },
			markdown = { "mdformat" },
			yaml = { "yamlfix" },
			yml = { "yamlfix" },
		},

        formatters = {
            -- ["sql-formatter"] = {
            --     command = "sql-formatter"
            -- }
            ["pg_format"] = {
                command = "pg_format",
                args = {
                    "-u", "1", -- lowercase keywords
                    "-f", "1", -- lowercase functions
                    "-T",      -- use tabs for indentation
                    "-g",      -- 1 or 2 newlines for queries
                    "-w", "80" -- 80 character line length
                }
            },
        }
	},
}
