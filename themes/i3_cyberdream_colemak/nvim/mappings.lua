-- tmux
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
map("n", "<C-i>", "<cmd> TmuxNavigateRight<CR>")
map("n", "<C-n>", "<cmd> TmuxNavigateDown<CR>")
map("n", "<C-e>", "<cmd> TmuxNavigateUp<CR>")

-- basic mappings
map({'n'}, 'k', 'i', {desc = 'enter insert mode'})
map({'n', 'o', 'x', }, "h", "h", { desc = ''})
map({'n', 'o', 'x', }, "n", "j")
map({'n', 'o', 'x', }, "e", "k")
map({'n', 'o', 'x', }, "i", "l")

-- https://www.youtube.com/watch?v=w7i4amO_zaE
-- move selected lines up/down in visualmode
map("v", "N", ":m '>+1<CR>gv=gv")
map("v", "E", ":m '<-2<CR>gv=gv")

-- join lines without moving cursor
map("n", "N", "mzJ`z")

-----------------------------------------------------------------
-- obsidian
-----------------------------------------------------------------
-- Show backlinks via Telescope
map("n", "<leader>ybl", "<cmd>ObsidianBacklinks<CR>", { desc = "show backlinks (Telescope)" })

-- template note
map("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert obsidian template"})

--------------------------------------------------------------------------------
-- harpoon
--------------------------------------------------------------------------------
local harpoon = require("harpoon")
map("n", "<leader>f", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "show harpoon list" })
map("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "harpoon add" })

map("n", "<leader>h", function()
	harpoon:list():select(1)
end, { desc = "harpoon(1)" })
map("n", "<leader>n", function()
	harpoon:list():select(2)
end, { desc = "harpoon(2)" })
map("n", "<leader>e", function()
	harpoon:list():select(3)
end, { desc = "harpoon(3)" })
map("n", "<leader>i", function()
	harpoon:list():select(4)
end, { desc = "harpoon(4)" })
map("n", "<leader>o", function()
	harpoon:list():select(5)
end, { desc = "harpoon(5)" })
map("n", "<leader>'", function()
	harpoon:list():select(5)
end, { desc = "harpoon(5)" })

map("n", "<leader><leader>h", function()
	harpoon:list():replace_at(1)
	vim.notify("added " .. vim.fn.expand("%:h") .. " to harpoon 1")
end, { desc = "set current buffer to harpoon(1)" })

map("n", "<leader><leader>n", function()
	harpoon:list():replace_at(2)
	vim.notify("added " .. vim.fn.expand("%:h") .. " to harpoon 2")
end, { desc = "set current buffer to harpoon(2)" })

map("n", "<leader><leader>e", function()
	harpoon:list():replace_at(3)
	vim.notify("added " .. vim.fn.expand("%:h") .. " to harpoon 3")
end, { desc = "set current buffer to harpoon(3)" })

map("n", "<leader><leader>i", function()
	harpoon:list():replace_at(4)
	vim.notify("added " .. vim.fn.expand("%:h") .. " to harpoon 4")
end, { desc = "set current buffer to harpoon(4)" })

map("n", "<leader><leader>o", function()
	harpoon:list():replace_at(5)
	vim.notify("added " .. vim.fn.expand("%:h") .. " to harpoon 5")
end, { desc = "set current buffer to harpoon(5)" })

map("n", "<leader><leader>'", function()
	harpoon:list():replace_at(6)
	vim.notify("added " .. vim.fn.expand("%:h") .. " to harpoon 6")
end, { desc = "set current buffer to harpoon(6)" })
