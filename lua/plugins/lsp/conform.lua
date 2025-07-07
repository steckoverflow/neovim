return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		-- Base formatters that are always available
		local formatters_by_ft = {
			lua = { "stylua" },
		}

		if vim.tbl_contains(_G["userconfig"].languages, "web") then
			formatters_by_ft.javascript = { "biome", "eslint_d", "prettier" }
			formatters_by_ft.javascriptreact = { "biome", "eslint_d", "prettier" }
			formatters_by_ft.typescript = { "biome", "eslint_d", "prettier" }
			formatters_by_ft.typescriptreact = { "biome", "eslint_d", "prettier" }
			formatters_by_ft.svelte = { "biome", "eslint_d", "prettier" }
			formatters_by_ft.css = { "biome", "prettier" }
			formatters_by_ft.scss = { "biome", "prettier" }
			formatters_by_ft.html = { "biome", "prettier" }
			formatters_by_ft.json = { "biome", "prettier" }
		end
		-- Add Golang formatters if Golang is enabled
		if vim.tbl_contains(_G["userconfig"].languages, "Golang") then
			formatters_by_ft.go = { "goimports", lsp_format = "last" }
		end

		-- Add Python formatters if Python is enabled
		if vim.tbl_contains(_G["userconfig"].languages, "Python") then
			formatters_by_ft.python = { "ruff_organize_imports", "ruff_format" }
		end

		--Godot
		if _G["userconfig"].languages.godot then
			formatters_by_ft.gdscript = { "gdformat" }
		end

		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
