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
			sql = { "sqls" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			sh = { "shfmt" },
			md = { "mdformat" },
			markdown = { "mdformat" },
			yaml = { "yamlfix" },
			yml = { "yamlfix" },
		},

        -- formatters = {
        --     pg_format = {
        --         args = {
        --             "--function-case=1",
        --             "--keyword-case=1",
        --             "--type-case=1",
        --             "--keep-newline",
        --             "--nogrouping",
        --             -- "--wrap-limit=80",
        --             "--wrap-after=1",
        --
        --
        --         }
        --     }
        -- }
	},
}
