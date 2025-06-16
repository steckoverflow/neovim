-- File tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {
	desc = "Toggle file explorer",
	silent = true,
})
vim.keymap.set("n", "<leader>o", ":NvimTreeFocus<CR>", {
	desc = "Focus file explorer",
	silent = true,
})

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Buffers
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save current buffer" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<C-q>", ":q<CR>", { desc = "Close current buffer" })

-- Global
--vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--LSP
vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

-- --AI
-- vim.keymap.set("n", "<LocalLeader>cs", function()
-- 	vim.cmd("CodeCompanionChat Toggle")
-- end, { desc = "Start CodeCompanion Chat" })
--
-- vim.keymap.set("v", "<LocalLeader>cr", function()
-- 	vim.cmd("CodeCompanionChat")
-- 	vim.cmd("CodeCompanionChat Add")
-- end, { desc = "Review selected code" })
--
-- -- Quick model switching (requires telescope)
-- vim.keymap.set("n", "<LocalLeader>cm", function()
-- 	require("codecompanion").setup({
-- 		adapters = {
-- 			ollama = function()
-- 				local model = vim.fn.input("Model name: ", "codellama:latest")
-- 				return require("codecompanion.adapters").extend("ollama", {
-- 					schema = {
-- 						model = { default = model },
-- 					},
-- 				})
-- 			end,
-- 		},
-- 	})
-- end, { desc = "Switch CodeCompanion model" })
