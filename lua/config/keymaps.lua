local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

--Clear highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Shortcuts for save and exit
map("n", "<leader>w", function()
	if vim.api.nvim_buf_get_name(0) == "" then
		vim.ui.input({
			prompt = "Enter file name: ",
		}, function(name)
			if name and name ~= "" then
				vim.cmd("write " .. vim.fn.fnameescape(name))
			end
		end)
	else
		vim.cmd.write()
	end
end, { desc = "Save Buffer" })

-- This is supposed to save and exit Neovim
map("n", "<leader>x", function()
	-- Close all terminal buffers first
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	vim.cmd("wqa")
end, { desc = "Kill terminals and exit" })

-- Close current buffer
-- TODO: Make it work better together with bufferline.
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit Window" })

-- Split window keymaps
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>,", ":split<CR>", { desc = "Horizontal split" })

--SQL
vim.keymap.set("n", "<leader>Db", ":DBUI<CR>", { desc = "Open Database UI" })
vim.keymap.set("n", "<leader>Dt", ":DBUIToggle<CR>", { desc = "Toggle Database UI" })
vim.keymap.set("n", "<leader>Da", ":DBUIAddConnection<CR>", { desc = "Add Database Connection" })
vim.keymap.set("n", "<leader>Df", ":DBUIFindBuffer<CR>", { desc = "Find Database Buffer" })

--Csv
vim.keymap.set("n", "<leader>cv", "<cmd>CsvViewEnable<cr>", { desc = "Enable CSV view" })
vim.keymap.set("n", "<leader>cd", "<cmd>CsvViewDisable<cr>", { desc = "Disable CSV view" })
vim.keymap.set("n", "<leader>ct", "<cmd>CsvViewToggle<cr>", { desc = "Toggle CSV view" })
