return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 200,
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	spec = {
		{ "<leader>f", group = "[F]ind" },
		--{ '<leader>t', group = '[T]oggle' },
		--{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
	},
}
