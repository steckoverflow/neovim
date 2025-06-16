return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			-- Options
			transparent = true, -- Enable transparent background
			italic_comments = true, -- Italicize comments
			dim_inactive_windows = true, -- Dim inactive windows
			bold_keywords = true, -- Bold keywords
			underline_strings = true, -- Underline strings
			cursorline = true, -- Enable cursor line highlighting
		})
		vim.cmd("colorscheme cyberdream")
	end,
}
