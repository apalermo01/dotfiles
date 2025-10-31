local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		handlers = {
			function(server_name)
				vim.lsp.config(server_name).setup({
					capabilities = capabilities,
				})
			end,


			["lua_ls"] = function()
				vim.lsp.config('lua_ls').setup({
					cmd = IS_NIXOS and { "lua-language-server" } or nil,
					capabilities = capabilities,
				})
			end,

			["yamlls"] = function()
				vim.lsp.config('yamlls').setup({
					settings = {
						yaml = {
							schemas = {
								["https://raw.githubusercontent.com/apalermo01/ricer/refs/heads/main/ricer_schema.json"] = "/theme.yml",
							},
						},
					},
				})
			end,

			["markdown_oxide"] = function()
				vim.lsp.config('markdown_oxide').setup({
					cmd = IS_NIXOS and { "markdown-oxide" } or nil,
					capabilities = vim.tbl_deep_extend("force", capabilities, {
						workspace = {
							didChangeWatchedFiles = {
								dynamicRegistration = true,
							},
						},
					}),
					root_dir = function(fname)
						local paths = {
							"0-technical-notes",
							"1-notes",
						}
						for _, sub in ipairs(paths) do
							local full = OBSIDIAN_NOTES_DIR .. "/" .. sub
							if fname:find(full, 1, true) then
								return full
							end
						end
						return vim.fn.getcwd()
					end,
				})
			end,

			["nil_ls"] = function()
				vim.lsp.config('nil_ls').setup({
					autostart = true,
					settings = {
						["nil"] = {
							testSetting = 42,
							formatting = {
								command = { "nixfmt-rfc-style" },
							},
						},
					},
				})
			end,
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function(_, opts)
		require("mason-lspconfig").setup(opts)
		local caps = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		vim.lsp.config("postgres_lsp", {
			cmd = { "postgrestools", "lsp-proxy" },
			filetypes = { "sql" },
			root_markers = {"sqitch.plan", ".git", "postgrestools.jsonc"},
			single_file_support = true,
			capabilities = caps,
		})
		vim.lsp.enable({ "postgres_lsp" })

        if IS_NIXOS then
            require('lspconfig').clangd.setup({
                cmd = { "/run/current-system/sw/bin/clangd" }
            })
        end
	end,
}
