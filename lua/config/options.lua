vim.o.wrap = false -- Don't wrap lines
vim.o.scrolloff = 15 -- Set scrolloff
vim.o.tabstop = 2 -- Set tab width
vim.o.expandtab = true
vim.o.hlsearch = false -- Set highlight on search
vim.wo.number = true -- Make line numbers default
vim.o.mouse = "a" -- Enable mouse mode
vim.o.breakindent = true -- Enable break indent

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

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true
