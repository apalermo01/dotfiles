-- top-level keys:
-- buffer operations:  <leader>b
-- tab operations:     <leader>t
--          exception: toggle trouble: <leader>tt
-- terminal operations: <leader><leader>t
-- lsp operations:     <leader>v
-- debug operatiosn:   <leader>d
-- telescope / picker: <leader>p
--          excepction: paste from clipboard: <leader>pc
-- formatting:         <leader>c
-- git:                <leader>g
-- harpoon / quick switching: <leader>1,2,3,4,5,6
--          -- do not use these keys for any other top level headers
-- obsidian            <leader>o
--          exception: show outline: <leader>ol

-----------------------------------------------------------------
-- functions
-----------------------------------------------------------------
-- use escape to clear highlights or close open windows
function CloseFloatingOrClearHighlight()
	local floating_wins = 0
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative ~= "" then
			floating_wins = floating_wins + 1
			vim.api.nvim_win_close(win, false)
		end
	end

	if floating_wins == 0 then
		vim.cmd("noh")
	end
end

-----------------------------------------------------------------
-- misc
-----------------------------------------------------------------

-- Newlines above and below without leaving normal mode
map("n", "oo", "o<Esc>k", { desc = "newline below without leaving normal mode" })
map("n", "OO", "O<Esc>j", { desc = "new line above witnout leaving normal mode" })

-- use escape to clear highlights and close floating windowns
map("i", "<C-c>", "<Esc>")
map("n", "<Esc>", CloseFloatingOrClearHighlight, { noremap = true, silent = true })

-- movement
map("n", "<C-d>", "<C-d>zz", { desc = "half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "half page up" })
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

-- https://www.youtube.com/watch?v=w7i4amO_zaE
-- move selected lines up/down in visualmode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected line up" })

-- join lines without moving cursor
-- map("n", "N", "mzJ`z")

-- paste over visual selection wihout yanking it
map("x", "<leader>p", '"_dP')

-- yank to system clipboard without any gymnastics
map({ "v", "n" }, "<leader>yc", '"+y')
map({ "v", "n" }, "<leader>pc", '"+p')

-- TODO: set up tmux sessionizer

-- this does some kind of magic that I saw here:
-- https://www.youtube.com/watch?v=w7i4amO_zaE
-- however, I never use it, so I'm commenting it out for now
-- map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- quickfix navigation
-- TODO: this currently overlaps with tmux
-- map("n", "<C-k>", "<cmd>cnext<CR>zz")
-- map("n", "<C-j>", "<cmd>cprev<CR>zz")

-- spellcheck
map("n", "<leader><leader>s", function()
	vim.wo.spell = not vim.wo.spell
end, { desc = "toggle spellcheck" })

-- file navigation
map("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- project navigation
map("n", "<leader>ol", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "toggle undo tree" })
map("n", "<leader>E", "<cmd>EditProjectConfig<CR>", { desc = "edit project config" })

-- navigate by { }
-- I don't remember what this does so I'm removing it for now
-- map("n", "[[", "?{<CR>w99[{")
-- map("n", "][", "/}<CR>b99]}")
-- map("n", "]]", "j0[[%/{<CR>")
-- map("n", "[]", "k$][%?}<CR>")

-- diffview
map("n", "<leader>df", "<cmd>DiffviewFileHistory %<cr>")

-- automatically go back into visual mode after indenting
map("v", ">", ">gv")
map("v", "<", "<gv")

-- window motions
map("n", "<leader>wh", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("n", "<leader>wj", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("n", "<leader>wk", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("n", "<leader>wl", "<cmd>wincmd l<CR>", { desc = "Go to right window" })
map("n", "<M-h>", "<C-w>h", { desc = "win left" })
map("n", "<M-j>", "<C-w>j", { desc = "win down" })
map("n", "<M-k>", "<C-w>k", { desc = "win up" })
map("n", "<M-l>", "<C-w>l", { desc = "win right" })
-----------------------------------------------------------------
-- terminal
-----------------------------------------------------------------
-- terminal mapping moved to `terminal.lua`
-- map("n", "<leader><leader>tr", "<cmd>tabnew | term<CR>", { desc = "open terminal in new tab" })
-- map("n", "<leader><leader>tt", "<cmd>lua require('FTerm').toggle()<cr>", { desc = "toggle floating terminal" })
-- map(
-- 	"t",
-- 	"<leader><leader>tt",
-- 	"<C-\\><C-n><cmd>lua require('FTerm').toggle()<cr>",
-- 	{ desc = "toggle floating terminal" }
-- )

-----------------------------------------------------------------
-- tabs
-----------------------------------------------------------------
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "make new tab" })
map("n", "<leader>t<leader", "<cmd>tabnext<cr>", { desc = "go to next tab" })
map("n", "<leader>tm", "<cmd>tabmove<cr>", { desc = "move tab" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "tabonly" })

-----------------------------------------------------------------
-- buffers
-----------------------------------------------------------------
map("n", "<leader>N", "<cmd>enew<CR>", { desc = "new buffer" })
map("n", "<leader>x", function()
	require("bufdelete").bufdelete(0, true)
end, { desc = "delete this buffer" })
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "next buffer", silent = true })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "previous buffer", silent = true })

-----------------------------------------------------------------
-- formatting <leader>c
-----------------------------------------------------------------
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
map({ "n", "v" }, "<leader>cc", "<leader>/", { desc = "toggle comment", remap = true })
map("n", "<leader>cm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-----------------------------------------------------------------
-- debug
-----------------------------------------------------------------

-- trouble
map("n", "<leader>dt", function()
	require("trouble").toggle({
		mode = "diagnostics",
		filter = { buf = 0 },
		pinned = true,
		focus = false,
	})
end, { desc = "toggle trouble" })

map("n", "]t", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "trouble: next diagnostic" })
map("n", "<leader>dn", function()
	require("trouble").next({ skip_groups = true, jump = true })
end, { desc = "trouble: next diagnostic" })

map("n", "[t", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "trouble: previous diagnostic" })
map("n", "<leader>dp", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end, { desc = "trouble: previous diagnostic" })

-----------------------------------------------------------------
-- obsidian
-----------------------------------------------------------------
-- Show backlinks via Telescope
map("n", "<leader>obl", "<cmd>Obsidian backlinks<CR>", { desc = "show backlinks (Telescope)" })

-- template note
map("n", "<leader>op", "<cmd>Obsidian template<CR>", { desc = "Insert obsidian template" })

-- tags
map("n", "<leader>ot", "<cmd>Obsidian tags<CR>", { desc = "Obsidian tags" })

-- Delete current note
map("n", "<leader>odd", ":!rm '%:p'<CR>:bd<CR>", { desc = "delete note" })

-- Open current file in the Obsidian app (requires `obsidian` CLI in PATH)
map("n", "<leader>oo", function()
	local vault_root = OBSIDIAN_NOTES_DIR
	local vault_name = vim.fn.fnamemodify(vault_root, ":t")
	local function urlencode(str)
		return str:gsub("([^%w%-_%.~])", function(c)
			return string.format("%%%02X", string.byte(c))
		end)
	end

	local abs = vim.fn.expand("%:p")
	if not vim.startswith(abs, vault_root) then
		vim.notify("File is not inside your Obsidian vault", vim.log.levels.WARN)
		return
	end

	local rel = abs:sub(#vault_root + 2)
	local uri = ("obsidian://open?vault=%s&file=%s"):format(vault_name, urlencode(rel))

	vim.system({ "obsidian", uri }, { detach = true })
end, { desc = "open current file in Obsidian" })

--------------------------------------------------------------------------------
-- TELESCOPE (pickers) (<leader>p prefix)
--------------------------------------------------------------------------------
local builtin = require("telescope.builtin")

-- Find all files (hidden + no ignore)
map("n", "<leader>pa", function()
	builtin.find_files({ hidden = true, no_ignore = true })
end, { desc = "Telescope: find all files" })

-- Search open buffers
map("n", "<leader>pb", builtin.buffers, { desc = "Telescope: search open buffers" })

-- Find files
map("n", "<leader>pf", builtin.find_files, { desc = "Telescope: find files" })

-- Live grep
map(
	"n",
	"<leader>pg",
	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "Telescope: live grep" }
)

-- git history
map("n", "<leader>ph", builtin.git_bcommits, { desc = "Telescope: commit history" })

-- Jumplist
map("n", "<leader>pj", builtin.jumplist, { desc = "Telescope: jumplist" })

-- List marks
map("n", "<leader>pma", builtin.marks, { desc = "Telescope: list marks" })

-- Search old files
map("n", "<leader>po", builtin.oldfiles, { desc = "Telescope: search old files" })

-- Resume last picker
map("n", "<leader>pr", builtin.resume, { desc = "Telescope: resume last picker" })

-- Spell suggestions
map("n", "<leader>ps", builtin.spell_suggest, { desc = "Telescope: spell suggest" })

-- List registers
map("n", '<leader>p"', builtin.registers, { desc = "Telescope: list registers" })

-- keymaps
map("n", "<leader>pk", builtin.keymaps, { desc = "Telescope: keymaps" })

-- workspace symbols
-- map("n", "<leader>pk", builtin.keymaps, { desc = "Telescope: keymaps" })

-- keymaps
-- map("n", "<leader>pk", builtin.keymaps, { desc = "Telescope: keymaps" })

-- workspace_symbol
-- map("n", "<leader>pd", builtin.lsp_definitions, { desc = "Telescope: lsp definition" })

-- Prompted grep for a string
-- map("n", "<leader>pw", function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end, { desc = "Telescope: search for a string" })

--------------------------------------------------------------------------------
-- LSP MAPS (<leader>v prefix)
--------------------------------------------------------------------------------
-- Create an augroup for LSP keymaps
local lsp_group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function(e)
		local buf = e.buf
		local client = assert(vim.lsp.get_client_by_id(e.data.client_id))
		local opts = { buffer = buf }

		-- Go to definition (normal and <leader>vd)
		map("n", "<leader>vd", function()
			vim.lsp.buf.definition()
		end, vim.tbl_extend("force", opts, { desc = "LSP: go to definition" }))

		-- Hover
		map("n", "K", function()
			vim.notify("reminder: KK to hover then k/j to scroll docs")
			vim.lsp.buf.hover({
				border = "single",
			})
		end, vim.tbl_extend("force", opts, { desc = "LSP: hover" }))

		-- Show diagnostic in floating
		map("n", "<leader>vk", function()
			vim.diagnostic.open_float({
				border = "single",
			})
		end, vim.tbl_extend("force", opts, { desc = "LSP: show diagnostic" }))

		-- Workspace symbols
		map("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, vim.tbl_extend("force", opts, { desc = "LSP: workspace symbols" }))

		-- Code actions
		map("n", "<leader>va", function()
			vim.lsp.buf.code_action()
		end, vim.tbl_extend("force", opts, { desc = "LSP: code actions" }))

		-- References
		map("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, vim.tbl_extend("force", opts, { desc = "LSP: references" }))

		-- Rename
		map("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, vim.tbl_extend("force", opts, { desc = "LSP: rename" }))

		-- Signature help (if supported)
		if client.supports_method("textDocument/signatureHelp") then
			map("n", "<C-s>", function()
				vim.lsp.buf.signature_help()
			end, vim.tbl_extend("force", opts, { desc = "LSP: signature help" }))
		end

		-- Go to next/prev diagnostic
		map("n", "<leader>vn", function()
			vim.lsp.buf.goto_next()
		end, vim.tbl_extend("force", opts, { desc = "LSP: next diagnostic" }))
		map("n", "]l", function()
			vim.lsp.buf.goto_next()
		end, { buffer = buf, desc = "LSP: next diagnostic" })

		map("n", "<leader>vp", function()
			vim.lsp.buf.goto_prev()
		end, vim.tbl_extend("force", opts, { desc = "LSP: previous diagnostic" }))
		map("n", "[l", function()
			vim.lsp.buf.goto_prev()
		end, { buffer = buf, desc = "LSP: previous diagnostic" })

		-- telescope keybindings
		map("n", "<leader>plr", builtin.lsp_references, { desc = "lsp references" })
		map("n", "<leader>pli", builtin.lsp_implementations, { desc = "lsp implementations" })
		map("n", "<leader>pld", builtin.lsp_definitions, { desc = "lsp definitions" })

		-- Special markdown_oxide handling (Obsidian)
		if client.name == "markdown_oxide" then
			map("n", "<leader>vrn", function()
				local file = vim.api.nvim_buf_get_name(0)
				local vault = OBSIDIAN_NOTES_DIR
				if not file:find(vault, 1, true) then
					vim.notify("Not in an Obsidian vault. Rename aborted.", vim.log.levels.WARN)
					return
				end
				vim.lsp.buf.rename()
			end, vim.tbl_extend("force", opts, { desc = "LSP: safe rename" }))

			map("n", "gf", function()
				vim.lsp.buf.definition()
			end, vim.tbl_extend("force", opts, { desc = "LSP: go to definition" }))

			-- Backlinks (list references)
			map("n", "obl", function()
				vim.lsp.buf.references()
			end, vim.tbl_extend("force", opts, { desc = "LSP: Obsidian backlinks" }))
		end

		vim.notify(client.name .. " attached to buffer")
	end,
})

--------------------------------------------------------------------------------
-- git (<leader>g prefix)
--------------------------------------------------------------------------------
map("n", "<leader>gs", vim.cmd.Git, { desc = "start git fugitive" })

-- git history
map("n", "<leader>gh", builtin.git_bcommits, { desc = "Telescope: commit history" })

-------------------------------
--- No neck pain --------------
-------------------------------

map("n", "<leader>ck", "<cmd>NoNeckPain<CR>")

-------------------------------
--- Vim Tmux Navigator --------
-------------------------------
map("n", "M-h", "<cmd><C-U>TmuxNavigateLeft<CR>")
map("n", "M-j", "<cmd><C-U>TmuxNavigateDown<CR>")
map("n", "M-k", "<cmd><C-U>TmuxNavigateUp<CR>")
map("n", "M-l", "<cmd><C-U>TmuxNavigateRight<CR>")

map("i", "<M-j>", "<C-o>j")
map("i", "<M-k>", "<C-o>k")
