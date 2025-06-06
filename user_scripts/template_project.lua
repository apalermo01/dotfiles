vim.notify("running <name of your project>.lua")

local path = "$HOME/Documents/git/"
vim.schedule(function()
    vim.keymap.set("n", "<leader>q", function()
    -- require('FTerm').run("bash " .. path)
    -- vim.cmd('split | terminal bash ' .. path)
    end, { desc = "run a script"})
end)
