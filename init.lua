--Presetting some things needed by for instance Lazy
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.have_nerd_font = true
vim.o.clipboard = "unnamedplus"

require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.functions")

--Colorscheme
vim.cmd("colorscheme lytmode")
