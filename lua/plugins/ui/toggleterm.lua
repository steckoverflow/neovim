return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- Size can be a number or function
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<leader>tt]], -- This will work in normal mode
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true, -- Apply open_mapping in insert mode
			terminal_mappings = true, -- Apply open_mapping in terminal mode
			persist_size = true,
			persist_mode = true,
			direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
			float_opts = {
				border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options
				width = math.floor(vim.o.columns * 0.8),
				height = math.floor(vim.o.lines * 0.8),
				winblend = 3,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		-- Additional keymaps for better control
		local opts = { noremap = true, silent = true }

		-- Normal mode toggle
		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)

		-- Insert mode toggle
		vim.keymap.set("i", "<leader>tt", "<esc><cmd>ToggleTerm<cr>", opts)

		-- Terminal mode escape (to get back to normal mode in terminal)
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)

		-- Terminal mode toggle (so you can close from within terminal)
		vim.keymap.set("t", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)

		-- Terminal mode toggle (so you can close from within terminal)
		vim.keymap.set("t", "<leader>q", "<cmd>ToggleTerm<cr>", opts)
	end,
}
