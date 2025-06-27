return {
	"linux-cultist/venv-selector.nvim",
	branch = "regexp",
	dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap-python", "nvim-telescope/telescope.nvim" },
	config = function()
		require("venv-selector").setup({})
	end,
	-- keys = {
	-- 	{ "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
	-- 	{ "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select VirtualEnv (cached)" },
	-- },
}
