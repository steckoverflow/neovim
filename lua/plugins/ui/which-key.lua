return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
	opts = {
		preset = "modern",
		delay = 0,
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>g", group = "Git" },
			{ "<leader>h", group = "Git Hunk", mode = { "n", "v" } },
			{ "<leader>s", group = "Search", mode = { "n", "v" } },
			{ "<leader>t", group = "Terminal" },
			{ "<leader>u", group = "Ui" },
			{ "<leader>c", group = "Csv", mode = { "n", "v" } },
			{ "<leader>d", group = "Debug" },
		},
	},
}
