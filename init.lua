vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true
vim.o.clipboard = "unnamedplus"

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.diagnostics")

-- Check if we are in Godot project, spawn server version of neovim
require("config.check-godot")

--Colorscheme
vim.cmd("colorscheme rose-pine")
