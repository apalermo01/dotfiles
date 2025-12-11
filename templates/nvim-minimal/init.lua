-- adapted from https://www.youtube.com/watch?v=skW3clVG5Fo
vim.cmd.colorscheme("unokai")

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false 
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true 
vim.opt.smartindent = true
vim.opt.autoindent = true 

vim.opt.ignorecase = true 
vim.opt.smartcase = true 
vim.opt.hlsearch = false 
vim.opt.incsearch = true

vim.opt.termguicolors = true 
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10  
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true 
vim.opt.synmaxcol = 300

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false 
vim.opt.undofile = true 
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 5000
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true 
vim.opt.autowrite = false

vim.opt.hidden = true 
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver20,r-cr:hor20,a:blinkwait700-blinkoff300-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
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
map = vim.keymap.set

map("n", "Y", "y$", { desc = "Yank to end of line" })

map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

map("n", "<leader>sv", ":vsplit<CR>", { desc = "split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "split window horizontally" })

map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

map("n", "<leader>pa", function() 
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file: ", path)
end)

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function() 
    vim.highlight.on_yank()
  end,
})

-- return to last edit position when opening files 
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then 
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})



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
map("n", "J", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "K", ":m .-2<CR>==", { desc = "Move line up" })

-- automatically go back into visual mode after indenting
map("v", ">", ">gv")
map("v", "<", "<gv")

map("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
map("n", "<leader>ff", ":find", { desc = "Find file" })


-----------------------------------------------------------------
-- remappings for colemak
-----------------------------------------------------------------
-- motions
map({ "n", "v", "o" }, "n", "j", { desc = "move down" })
map({ "n", "v", "o" }, "e", "k", { desc = "move up" })
map({ "n", "v" }, "i", "l", { desc = "move right", noremap = true })

map({ "n", "o" }, "k", "i", { desc = "enter insert mode", noremap = true })

map({ "n" }, "j", "nzz", { desc = "next item in search" })
map({ "n" }, "J", "Nzz", { desc = "previous item in search" })

map({ "n", "v", "o" }, "l", "e", { desc = "end of word" })
map({ "n", "v", "o" }, "L", "E", { desc = "end of WORD"})

map("v", "N", ":m '>+1<CR>gv=gv", { desc = "move selected line down" })
map("v", "E", ":m '<-2<CR>gv=gv", { desc = "move selected line up" })
map("n", "N", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "E", ":m .-2<CR>==", { desc = "Move line up" })

-- window motions
map("n", "<leader>wh", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("n", "<leader>wn", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("n", "<leader>we", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("n", "<leader>wi", "<cmd>wincmd l<CR>", { desc = "Go to right window" })
map("n", "<M-h>", "<C-w>h", {desc="win left"})
map("n", "<M-n>", "<C-w>j", {desc="win down"})
map("n", "<M-e>", "<C-w>k", {desc="win up"})
map("n", "<M-i>", "<C-w>l", {desc="win right"})
-- tmux
-- map("n", "<leader>th", "<cmd>TmuxNavigateLeft<CR>", { desc = "Tmux navigate left" })
-- map("n", "<leader>tn", "<cmd>TmuxNavigateDown<CR>", { desc = "Tmux navigate down" })
-- map("n", "<leader>te", "<cmd>TmuxNavigateUp<CR>", { desc = "Tmux navigate up" })
-- map("n", "<leader>ti", "<cmd>TmuxNavigateRight<CR>", { desc = "Tmux navigate right" })
-- vim.g.tmux_navigator_no_mappings = 1
-- map("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>")
-- map("n", "<M-n>", "<cmd>TmuxNavigateDown<CR>")
-- map("n", "<M-e>", "<cmd>TmuxNavigateUp<CR>")
-- map("n", "<M-i>", "<cmd>TmuxNavigateRight<CR>")
map({ "n", "x" }, "gn", "gj", { desc = "screen down" })
map({ "n", "x" }, "ge", "gk", { desc = "screen up (Colemak)" })


-- -- telescope
-- local telescope = require("telescope")
-- local actions = require("telescope.actions")
-- telescope.setup({
-- 	defaults = {
-- 		mappings = {
-- 			n = {
--
-- 				["j"] = false,
-- 				["k"] = false,
-- 				["n"] = actions.move_selection_next,
-- 				["e"] = actions.move_selection_previous,
-- 			},
-- 		},
-- 	},
-- })
--
-- -- LSP Signature 
-- map("i", "<M-n>", "<C-o>j")
-- map("i", "<M-e>", "<C-o>k")
--
