local map = vim.keymap.set

vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.conceallevel = 3

local opts = { buffer = true, silent = true }

map("n", "n", "j", opts)
map("n", "e", "k", opts)
map("n", "j", "nzz")
map("n", "J", "Nzz")
