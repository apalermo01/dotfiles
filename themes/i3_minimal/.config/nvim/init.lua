vim.cmd([[filetype plugin on]])
vim.cmd([[syntax on]])

-- Globals
OBSIDIAN_NOTES_DIR = os.getenv("OBSIDIAN_NOTES_DIR") or "/home/alex/Documents/git/notes"
OBSIDIAN_NOTES_SUBDIR = os.getenv("OBSIDIAN_NOTES_SUBDIR") or "0-inbox"
OBSIDIAN_TEMPLATE_FOLDER = os.getenv("OBSIDIAN_TEMPLATE_FOLDER") or "5-templates"

map = vim.keymap.set

function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require("oil").get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end

-- boolean flag to check if we're running nix
function is_nixos()
	local os_release = vim.fn.readfile("/etc/os-release")
	for _, line in ipairs(os_release) do
		if line:match("^ID=nixos") then
			return true
		end
	end
	return false
end

IS_NIXOS = is_nixos()

-- return 2 variants of a function depending on whether or not we're running nix
-- borrowed from https://github.com/NicoElbers/nixPatch-nvim/tree/main 
switchNix = function(nonNix, nix)
    if vim.g.nix == true then 
        return nix
    else
        return nonNix
    end 
end

require("config.remap")
require("config.opts")
require("config.lazy_init")
require("config.cmds")

vim.cmd.colorscheme("default")
vim.cmd([[set guifont=JetBrainsMono\ NFM\ medium]])
