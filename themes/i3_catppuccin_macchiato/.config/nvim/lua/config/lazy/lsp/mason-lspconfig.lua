local cmp_lsp = require("cmp_nvim_lsp")

local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

local function prefer_system(cmd)
	return (vim.fn.executable(cmd) == 1) and { cmd } or nil
end

return {
	"williamboman/mason-lspconfig.nvim",
	opts = {

		automatic_installation = switchNix(true, false),
		ensure_installed = switchNix({
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
		}, {}),

		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup({
                    cmd = prefer_system("lua-language-server"),
					capabilities = capabilities,
				})
			end,

			-- ["pyright"] = function()
			-- 	print("running handler for pyright")
			-- 	require("lspconfig")["pyright"].setup({
			-- 		capabilities = capabilities,
			-- 	})
			-- end,

			["markdown_oxide"] = function()
				require("lspconfig").markdown_oxide.setup({
                    cmd = prefer_system("markdown-oxide"),
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
                    cmd = prefer_system('nil'),
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
}
