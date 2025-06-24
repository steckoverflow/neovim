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

map("n", "<leader>x", function()
	-- Close all terminal buffers first
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	vim.cmd("wqa")
end, { desc = "Kill terminals and exit" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit Window" })

--Resize window using <ctrl> arrow keys with smart behavior
map("n", "<C-Up>", function()
	local win_id = vim.fn.winnr()
	local above_win = vim.fn.winnr("k")

	if above_win == win_id then
		vim.cmd("resize -2")
	else
		vim.cmd("resize +2")
	end
end, { desc = "Increase Window Height" })

map("n", "<C-Down>", function()
	local win_id = vim.fn.winnr()
	local above_win = vim.fn.winnr("k")

	if above_win == win_id then
		vim.cmd("resize +2")
	else
		vim.cmd("resize -2")
	end
end, { desc = "Decrease Window Height" })

map("n", "<C-Right>", function()
	local win_id = vim.fn.winnr()
	local left_win = vim.fn.winnr("h")

	if left_win == win_id then
		vim.cmd("vertical resize +2")
	else
		vim.cmd("vertical resize -2")
	end
end, { desc = "Increase Window Width" })

map("n", "<C-Left>", function()
	local win_id = vim.fn.winnr()
	local left_win = vim.fn.winnr("h")

	if left_win == win_id then
		vim.cmd("vertical resize -2")
	else
		vim.cmd("vertical resize +2")
	end
end, { desc = "Decrease Window Width" })
