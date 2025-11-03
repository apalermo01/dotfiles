local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

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
            if vim.fn.expand("%:p"):match(vim.fn.expand('~/Documents/git/notes/')) then
                on_dir(vim.fn.getcwd())
            end
        end
        -- root_markers = { '.git', '.obsidian' }
		-- root_dir = function(fname)
		-- 	local paths = {
		-- 		"0-technical-notes",
		-- 		"1-notes",
		-- 	}
		-- 	for _, sub in ipairs(paths) do
		-- 		local full = OBSIDIAN_NOTES_DIR .. "/" .. sub
		-- 		if fname:find(full, 1, true) then
		-- 			return full
		-- 		end
		-- 	end
		-- 	return vim.fn.getcwd()
		-- end,
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
		cmd = IS_NIXOS and { "/run/current-system/sw/bin/clangd" } or { "clangd" },
		filetypes = { "c", "cpp" },
	},
}

for name, config in pairs(servers) do
    vim.lsp.enable(name)
	vim.lsp.config(name, config)
end

