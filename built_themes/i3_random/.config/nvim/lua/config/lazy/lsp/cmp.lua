-- auto complete

-- `/` cmdline setup.
local cmp = require("cmp")
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"onsails/lspkind.nvim",
		"stevearc/conform.nvim",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"f3fora/cmp-spell",
		"Dynge/gitmoji.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local luasnip = require("luasnip")
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			if col == 0 then
				return false
			end
			local prev = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
			return not prev:match("%s")
        end
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			preselect = "None",

			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = {
						menu = 50,
						abbr = 50,
					},
					ellipsis_char = "...",
					show_labelDetails = true,
					before = function(entry, vim_item)
						vim_item.menu = entry.source.name
						return vim_item
					end,
				}),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				-- ["+"] = cmp.mapping.select_next_item(cmp_select),
				-- ["<C-e>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-e>"] = cmp.mapping.select_prev_item(cmp_select),
				-- ["$"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-a>"] = cmp.mapping.abort(),
				-- ["<C-o>"] = cmp.mapping.open_docs(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                -- ["]"] = cmp.mapping.confirm({ select = false }), -- ] is in layer above y
                -- ["<C-y>"] = cmp.mapping.confirm({ select = false }), -- ] is in layer above y
				["<Tab>"] = cmp.mapping(function(fallback)
                    vim.notify("use <c-n> and <c-p> to scroll cmp")
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(cmp_select)
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "render-markdown" },
				{ name = "obsidian" },
				{ name = "spell" },
				-- { name = 'gitmoji' },
				{ name = "path" },
			}),
		})
	end,
}
