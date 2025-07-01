return {
	"linux-cultist/venv-selector.nvim",
	branch = "regexp",
	dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap-python", "nvim-telescope/telescope.nvim" },
	config = function()
		require("venv-selector").setup({})
	end,
}
