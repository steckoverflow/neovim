vim.diagnostic.config({
	virtual_text = {
		enabled = true,
		source = "if_many", -- Show source if multiple LSPs are attached
		spacing = 4, -- Number of spaces after diagnostics
		prefix = "●", -- Character to show before the diagnostic message
		severity_sort = true -- Sort by severity
	},
	signs = true, -- Show signs in the sign column
	underline = true, -- Underline diagnostic text
	update_in_insert = false, -- Don't update diagnostics while typing
	severity_sort = true,
})
