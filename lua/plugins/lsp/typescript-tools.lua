if not vim.tbl_contains(_G["userconfig"].languages, "web") then
	return {}
end

local function is_volta_installed()
	return vim.fn.executable("volta") == 1
end

local opts = {
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
}

if is_volta_installed() then
	opts.settings = {
		tsserver_path = vim.env.HOME .. "/.volta/tools/image/packages/typescript/bin/tsserver",
	}
else
	vim.notify("Volta is not installed, using default tsserver path.", vim.log.levels.INFO)

	opts.settings = {
		tsserver_path = nil,
	}
end

return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = opts,
}
