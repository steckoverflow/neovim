vim.o.wrap = false -- Don't wrap lines
-- Set scrolloff
vim.o.scrolloff = 15

-- Set tab width
vim.o.tabstop = 2
-- vim.o.list = true
-- vim.o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.expandtab = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Relative Line number
vim.wo.relativenumber = true

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Disable Statusline
vim.o.laststatus = 0
vim.o.ruler = false
vim.o.statusline = " "

-- Set default splits
vim.o.splitright = true
vim.o.splitbelow = true
