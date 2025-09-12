
-----------------------------------------------------------------
-- remappings for colemak
-----------------------------------------------------------------
-- motions
map({ "n", "v" }, "n", "j", { desc = "move down" })
map({ "n", "v" }, "e", "k", { desc = "move up" })
map({ "n", "v" }, "i", "l", { desc = "move right" })

map({ "n" }, "k", "i", { desc = "enter insert mode" })
map({ "n" }, "K", "I", { desc = "capital I" })

map({ "n" }, "j", "nzz", { desc = "next item in search" })
map({ "n" }, "J", "Nzz", { desc = "previous item in search" })

map({ "n", "v" }, "l", "e", { desc = "end of word" })

-- window motions
map("n", "<leader>wh", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("n", "<leader>wn", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("n", "<leader>we", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("n", "<leader>wi", "<cmd>wincmd l<CR>", { desc = "Go to right window" })

-- tmux
map("n", "<leader>th", "<cmd>TmuxNavigateLeft<CR>", { desc = "Tmux navigate left" })
map("n", "<leader>tn", "<cmd>TmuxNavigateDown<CR>", { desc = "Tmux navigate down" })
map("n", "<leader>te", "<cmd>TmuxNavigateUp<CR>", { desc = "Tmux navigate up" })
map("n", "<leader>ti", "<cmd>TmuxNavigateRight<CR>", { desc = "Tmux navigate right" })

map({ "n", "x" }, "gn", "gj", { desc = "screen down" })
map({ "n", "x" }, "ge", "gk", { desc = "screen up (Colemak)" })

require('hardtime').setup({
   -- keep your usual global switches as you like
    restriction_mode = "block",
    allow_different_key = true,
    disable_mouse = true,
    hint = true,
    notification = true,

    ------------------------------------------------------------------
    -- 1) Colemak: treat h n e i as the four directional motions
    ------------------------------------------------------------------
    restricted_keys = {
      ["h"]  = { "n", "x" }, -- left
      ["n"]  = { "n", "x" }, -- down (you map n->j)
      ["e"]  = { "n", "x" }, -- up   (you map e->k)
      ["i"]  = { "n", "x" }, -- right (you map i->l)
      ["+"]  = { "n", "x" },
      ["gn"] = { "n", "x" }, -- screen-down (gj)
      ["ge"] = { "n", "x" }, -- screen-up   (gk)  ⚠ see note below
      ["<C-M>"] = { "n", "x" },
      ["<C-N>"] = { "n", "x" },
      ["<C-P>"] = { "n", "x" },
    },

    ------------------------------------------------------------------
    -- 2) Keep arrows disabled (fine for colemak too)
    ------------------------------------------------------------------
    disabled_keys = {
      ["<Up>"]    = { "", "i" },
      ["<Down>"]  = { "", "i" },
      ["<Left>"]  = { "", "i" },
      ["<Right>"] = { "", "i" },
    },

    ------------------------------------------------------------------
    -- 3) Hints: disable a few hjkl-based defaults and add Colemak ones
    --    Any key set to `false` disables the plugin’s default pattern.
    ------------------------------------------------------------------
    hints = {
      -- disable misleading defaults
      ["[kj][%^_]"]   = false,    -- becomes [ne][%^_]
      ["%^i"]         = false,    -- insert is 'k' for you
      ["%D[j+]O"]     = false,    -- down is 'n'
      ["[^fFtT]li"]   = false,    -- right+insert becomes 'ik'
      ["[^dcy=]F.l"]  = false,    -- right is 'i'
      ["[^dcy=]t.l"]  = false,    -- right is 'i'
      ["V%d[kj][dcy=<>]"]     = false, -- visual + move with j/k
      ['V%d[kj]".[dy]']       = false,
      ["V%d%d[kj][dcy=<>]"]   = false,
      ['V%d%d[kj]".[dy]']     = false,

      -- Colemak equivalents
      ["[ne][%^_]"] = {
        message = function(key)
          -- up (e) → recommend '-', down (n) → recommend <CR> or '+'
          return "Use " .. (key:sub(1,1) == "e" and "-" or "<CR> or +") .. " instead of " .. key
        end,
        length = 2,
      },
      ["%^k"] = {
        message = function() return "Use I instead of ^k" end,
        length = 2,
      },
      ["%D[n+]O"] = {
        message = function(keys) return "Use o instead of " .. keys:sub(2) end,
        length = 3,
      },
      ["[^fFtT]ik"] = {
        message = function() return "Use a instead of ik" end,
        length = 3,
      },
      ["[^dcy=]F.i"] = {
        message = function(keys)
          return "Use T" .. keys:sub(3,3) .. " instead of " .. keys:sub(2)
        end,
        length = 4,
      },
      ["[^dcy=]t.i"] = {
        message = function(keys)
          return "Use f" .. keys:sub(3,3) .. " instead of " .. keys:sub(2)
        end,
        length = 4,
      },

      -- Visual-mode “don’t overuse V + move” with n/e instead of j/k
      ["V%d[ne][dcy=<>]"] = {
        message = function(keys)
          return "Use " .. keys:sub(4,4) .. keys:sub(2,3) .. " instead of " .. keys
        end,
        length = 4,
      },
      ['V%d[ne]".[dy]'] = {
        message = function(keys)
          return "Use " .. keys:sub(4,6) .. keys:sub(2,3) .. " instead of " .. keys
        end,
        length = 6,
      },
      ["V%d%d[ne][dcy=<>]"] = {
        message = function(keys)
          return "Use " .. keys:sub(5,5) .. keys:sub(2,4) .. " instead of " .. keys
        end,
        length = 5,
      },
      ['V%d%d[ne]".[dy]'] = {
        message = function(keys)
          return "Use " .. keys:sub(5,7) .. keys:sub(2,4) .. " instead of " .. keys
        end,
        length = 7,
      },
    },
})
