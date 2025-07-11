local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

return {
	"williamboman/mason-lspconfig.nvim",
	opts = {

		automatic_installation = not IS_NIXOS,
		ensure_installed = IS_NIXOS and {
			"html",
			"cssls",
			"clangd",
			"pyright",
			"ts_ls",
			"jsonls",
			"nil_ls",
			"bashls",
            "yamlls",
		} or {
            "lua_ls",
			"html",
			"cssls",
			"clangd",
			"pyright",
			"ts_ls",
			"jsonls",
			"nil_ls",
			"markdown_oxide",
			"bashls",
            "yamlls",
		},

		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup({
					cmd = nixos and { "lua-language-server" } or nil,
					capabilities = capabilities,
				})
			end,

			["yamlls"] = function()
				require("lspconfig").lua_ls.setup({
                    settings = {
                        yaml = {
                            schemas = {
                                ["https://raw.githubusercontent.com/apalermo01/ricer/refs/heads/main/ricer_schema.json"] = "/theme.yml"
                            } 
                        }
                    }
				})
			end,

			["markdown_oxide"] = function()
				require("lspconfig").markdown_oxide.setup({
					cmd = nixos and { "markdown-oxide" } or nil,
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
				require("lspconfig").nil_ls.setup({
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
    config = function(_, opts)
        require("mason-lspconfig").setup(opts)
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")
        local caps      = vim.tbl_deep_extend(
          "force", {},
          vim.lsp.protocol.make_client_capabilities(),
          require("cmp_nvim_lsp").default_capabilities()
        )

        lspconfig.postgres_lsp.setup({
          cmd                 = { "postgrestools", "lsp-proxy" },             -- correct binary name
          filetypes           = { "sql" },
          root_dir            = util.root_pattern("sqitch.plan", ".git", "postgrestools.jsonc"),
          single_file_support = true,
          capabilities        = caps,
        })
    end
}
