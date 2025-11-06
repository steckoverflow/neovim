return {
	"linux-cultist/venv-selector.nvim",
	dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap-python", "nvim-telescope/telescope.nvim" },
	ft = "python",
	config = function()
		require("venv-selector").setup({})
	end,
}
