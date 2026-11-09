-- mapleader setup
vim.g.mapleader = " "
vim.g.localmapleader = ","

-- registery as a server when neovim started
if vim.fn.empty(vim.v.servername) == 1 then
	local sock = vim.fn.stdpath("run") .. "/nvim-" .. tostring(os.time()) .. ".sock"
	vim.fn.serverstart(sock)
end

require("keymap")
require("options")

-- lazy load
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(
	-- load plugins under plugins/, plugins/ui/, plugins/coding/, plugins/editor.
	{ { import = "plugins" }, { import = "plugins.editor" }, { import = "plugins.ui" }, { import = "plugins.coding" } },
	{
		checker = {
			enabled = true,
			frequency = 3600, -- update check interval: 1h
			check_plugins = true,
			notify = false,
		},
	}
)
