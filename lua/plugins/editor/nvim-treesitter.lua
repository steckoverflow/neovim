return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		local ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"html",
			"bash",
			"css",
			-- NOTE: Enable via userprofile data processing instead. Conflicts with rainbow csv plugin
			-- "csv",
			"dockerfile",
			"dot",
			"json",
			"json5",
			"sql",
			"terraform",
			"toml",
			-- Copilot
			"markdown",
			"markdown_inline",
			"yaml",
		}
		-- Add Golang parsers if Golang is enabled
		if vim.tbl_contains(_G["userconfig"].languages, "golang") then
			vim.list_extend(ensure_installed, {
				"go",
				"gomod",
				"gosum",
				"gowork",
			})
		end
		-- Add Python parsers if Python is enabled
		if vim.tbl_contains(_G["userconfig"].languages, "python") then
			vim.list_extend(ensure_installed, {
				"python",
			})
		end
		-- Godot
		if _G["userconfig"].extras.enable_godot then
			vim.list_extend(ensure_installed, {
				"gdscript",
				"gdshader",
				"glsl",
				"godot_resource",
			})
		end

		configs.setup({
			modules = {},
			ignore_install = {},
			ensure_installed = ensure_installed,
			auto_install = false,
			sync_install = false,
			highlight = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>", -- set to `false` to disable one of the mappings
					node_incremental = "<Enter>",
					scope_incremental = false,
					node_decremental = "<Backspace>",
				},
			},
		})
	end,
}
