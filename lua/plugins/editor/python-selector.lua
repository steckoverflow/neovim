return {
	"linux-cultist/venv-selector.nvim",
	branch = "regexp",
	lazy = false,
	dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap-python" },
	keys = {
		{
			"<leader>vs",
			"<cmd>VenvSelect<cr>",
			desc = "Select VirtualEnv (Snacks Picker)",
		},
		{ "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select VirtualEnv (cached)" },
	},
	picker = "snacks",
	---@type venv-selector.Config
	opts = {},
}
