---@type userconfig
_G.userconfig = require("config.userconfig").config

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true
vim.o.clipboard = "unnamedplus"

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.diagnostics")

-- NOTE: Godot comes with builtin LSP & Dap support, but Neovim needs to run in server mode.
-- See readme for further configuration.
if _G.userconfig.extras.enable_godot then
	local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
	if gdproject then
		io.close(gdproject)
		vim.fn.serverstart("/tmp/godot.pipe")
	end
end

--Colorscheme

if _G.userconfig.colorscheme then
	vim.cmd("colorscheme " .. _G.userconfig.colorscheme)
else
	vim.cmd("colorscheme rose-pine")
end
