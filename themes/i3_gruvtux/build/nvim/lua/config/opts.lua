local set = vim.opt
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local group = augroup("config", {})

-- functions
function SetTabwidth2()
	vim.opt_local.tabstop = 2
	vim.opt_local.shiftwidth = 2
	vim.opt_local.softtabstop = 2
end

-- General
set.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20"

set.number = true
set.rnu = true
set.cursorline = true
set.wrap = false
set.scrolloff = 8
set.sidescrolloff = 8

set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true
set.smartindent = true 
set.autoindent = true

set.ignorecase = true
set.smartcase = true
set.hlsearch = true
set.incsearch = true

set.termguicolors = true
set.signcolumn = "yes"
-- set.colorcolumn = "80"
set.showmatch = true
set.matchtime = 2
set.cmdheight = 1
set.completeopt = "menuone,noinsert,noselect"
set.showmode = false
set.pumheight = 10
set.pumblend = 10  
set.winblend = 0
-- set.concealcursor = ""
set.lazyredraw = true 
set.synmaxcol = 300

set.swapfile = false
set.backup = false
set.writebackup = false
set.undofile = true
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.updatetime = 300
-- set.timeoutlen = 5000
-- set.ttimeoutlen = 0
set.autoread = true 
set.autowrite = false

set.showcmd = true
set.showmode = true
set.compatible = false
set.syntax = "on"
set.wildmenu = true

set.hidden = true
set.backspace = "indent,eol,start"
set.autochdir = false 
set.iskeyword:append("-")
set.path:append("**")
set.selection = "exclusive"
set.mouse = "a"
set.clipboard:append("unnamedplus")

set.linebreak = true

vim.cmd([[set path+=**]])
vim.cmd([[set complete+=k]])
vim.cmd([[filetype plugin on]])
vim.cmd([[set spell spelllang=en_us]])
vim.cmd([[set spellfile=~/.config/en.utf-8.add]])
vim.cmd([[set guifont=JetBrainsMono\ Nerd\ Font\ Mono]])
vim.cmd([[set completeopt=menu,preview,menuone,noselect]])


-- UI
set.so = 7
vim.o.cursorlineopt = "both"
vim.o.termguicolors = true
vim.cmd([[set conceallevel=2]])
vim.cmd([[set foldcolumn=1]])
local border = {
	{ "🭽", "FloatBorder" },
	{ "▔", "FloatBorder" },
	{ "🭾", "FloatBorder" },
	{ "▕", "FloatBorder" },
	{ "🭿", "FloatBorder" },
	{ "▁", "FloatBorder" },
	{ "🭼", "FloatBorder" },
	{ "▏", "FloatBorder" },
}

vim.cmd([[let g:markdown_folding=1]])
vim.cmd([[set nofoldenable]])
-- folding behavior

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

local ft_group = augroup("ftgroup", {})

autocmd("FileType", {
	group = ft_group,
	pattern = { "nix" },
	callback = SetTabwidth2,
})

autocmd("FileType", {
	group = ft_group,
	pattern = {
		"nix",
		"lua",
		"python",
		"i3config",
		"man",
		"go",
		"gomod",
		"checkhealth",
		"gitcommit",
	},
	callback = function()
		vim.opt_local.spell = false
	end,
})

autocmd("FileType", {
	group = ft_group,
	pattern = { "c", "cpp" },
    callback = SetTabwidth2
})

-- autocmd("FileType", {
-- 	group = ft_group,
-- 	pattern = { "man" },
-- 	callback = function()
-- 		vim.opt_local.number = true
-- 		vim.opt_local.relativenumber = true
-- 		vim.opt_local.conceallevel = 3
--
-- 		local opts = { buffer = true, silent = true }
--
-- 		map("n", "n", "j", opts)
-- 		map("n", "e", "k", opts)
-- 		map("n", "j", "nzz")
-- 		map("n", "J", "Nzz")
-- 	end,
-- })
