
vim.notify = require('notify')
require('telescope').load_extension('emoji')
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local group = augroup("config", {})

-- show some reminders on startup 
autocmd("VimEnter", {
    callback = function() 
        vim.notify("Reminders: \n"..
                   "K          => LSP hover \n"..
                   "              Then <c-w>w to focus floating window\n"..
                   "C-u / C-d  => scroll docs in completion window\n" ..
                   "l/L        => end of word / WORD"
        )
    end,
})


-- show reminders for keybindings when opening diffview
vim.api.nvim_create_autocmd("User", {
    pattern = "DiffviewViewEnter",
    callback = function()
        vim.notify("Diffview reminders: \n"..
                   "<leader>co  => choose OUR version\n"..
                   "<leader>ct  => choose THEIR version\n"..
                   "<leader>cb  => choose BASE version\n"..
                   "<leader>ca  => choose ALL versions\n"..
                   "[c / ]c     => jump between diffs\n"..
                   "dx          => delete conflict region\n"..
                   "<leader>ct  => close tab (closing diffview)")
    end,
})

-- obsidian: update date updated when saving a note
autocmd("BufWritePre", {
	pattern = "*.md",
	callback = function()
		local path = vim.api.nvim_buf_get_name(0)
		if not string.find(path, "5-Templates") then
			local current_date = os.date("%Y-%m-%d")
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

			local in_frontmatter = false
			for i, line in ipairs(lines) do
				if line:match("^---") then
					if in_frontmatter then
						break
					else
						in_frontmatter = true
					end
				elseif in_frontmatter and line:match("^date_modified:") then
					lines[i] = "date_modified: " .. current_date
					vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
					break
				end
			end
		end
	end,
})


-- trouble: close when closing buffer
local trouble = require("trouble")

local function view_is_for(bufnr)
	if not trouble.is_open() then
		return false
	end
	local items = trouble.get_items()

	return #items > 0 and items[1].buf == bufnr
end

local function maybe_close_trouble(bufnr)
	if view_is_for(bufnr) then
		vim.schedule(function()
			pcall(trouble.close)
		end)
	end
end

-- call :q / window close
autocmd("WinClosed", {
	callback = function(args)
		local win = tonumber(args.match)
		if win == nil then
			vim.notify("cmds.lua WinClosed autocmd - could not convert " .. args.match .. " to a number")
			return
		end
		local buf = vim.api.nvim_win_get_buf(win)
		maybe_close_trouble(buf)
	end,
})

-- buffer delete
autocmd({ "BufDelete", "BufWipeout" }, {
	callback = function(args)
		maybe_close_trouble(args.buf)
	end,
})

-- editor quit
autocmd("QuitPre", {
	callback = function()
		-- local trouble = require("trouble")
		if trouble.is_open() then
			pcall(trouble.close)
		end
	end,
})

-- use firefox to open urls
local _orig_open = vim.ui.open

vim.ui.open = function(input, opts)
	local target = input or vim.fn.expand("<cfile>")

	if target:match("^[%a][%w+,-]*://") then
		vim.fn.jobstart({ "firefox", target }, { detach = true })
		vim.notify("opening " .. target .. " in firefox")
	else
		return _orig_open(input, opts)
	end
end

autocmd("BufReadPost", {
	pattern = { "*" },
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.api.nvim_exec("normal! g'\"", false)
		end
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("NoNeckPain")
    end,
})

-- snippets 
require("luasnip.loaders.from_vscode").lazy_load()

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() 
    vim.highlight.on_yank()
  end,
})

map("n", "<leader>pa", function() 
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file: ", path)
end)
