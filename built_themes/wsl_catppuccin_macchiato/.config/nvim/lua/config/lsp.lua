local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())


-- borders on floating windows
-- vim.lsp.util.open_floating_preview.Opts

-- server settings
local servers = {
	lua_ls = {
		capabilities = capabilities,
		cmd = IS_NIXOS and { "lua-language-server" } or nil,
	},

	yamlls = {
		capabilities = capabilities,
		settings = {
			yaml = {
				schemas = {
					["https://raw.githubusercontent.com/apalermo01/ricer/refs/heads/main/ricer_schema.json"] = "/theme.yml",
				},
			},
		},
	},

	markdown_oxide = {

		cmd = IS_NIXOS and { "markdown-oxide" } or nil,
		capabilities = vim.tbl_deep_extend("force", capabilities, {
			workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			},
		}),
        -- root_dir = vim.fn.expand('~/Documents/git/notes')
        root_dir = function(bufnr, on_dir)
            local file = vim.fn.expand("%:p")
            if file:match('./git/notes/.') or file:match('./github/notes/.') then
                on_dir(vim.fn.getcwd())
            end
        end
	},

	nil_ls = {
		capabilities = capabilities,
		autostart = true,
		settings = {
			["nil"] = {
				testSetting = 42,
				formatting = {
					command = { "nixfmt-rfc-style" },
				},
			},
		},
	},

	postgres_lsp = {
		capabilities = capabilities,
		cmd = { "postgrestools", "lsp-proxy" },
		filetypes = { "sql" },
		root_markers = { "sqitch.plan", ".git", "postgrestools.jsonc" },
		single_file_support = true,
	},

	clangd = {
		capabilities = capabilities,
        cmd = { "clangd" },
		filetypes = { "c", "cpp" },
	},

    pyright = {
        capabilities = capabilities
    },
}

for name, config in pairs(servers) do
    vim.lsp.enable(name)
	vim.lsp.config(name, config)
end

