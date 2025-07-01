return {
	{
		"QuickGD/quickgd.nvim",
		ft = { "gdshader", "gdshaderinc" },
		cmd = { "GodotRun", "GodotRunLast", "GodotStart" },
		init = function()
			vim.filetype.add({
				extension = {
					gdshaderinc = "gdshaderinc",
				},
			})
		end,
	},
	-- Extending with Blink Godot
	{
		"saghen/blink.cmp",
		opts_extend = {
			sources = { "quickgd" },
			providers = {
				quickgd = {
					name = "quickgd",
					module = "quickgd.blink",
				},
			},
		},
	},
}
