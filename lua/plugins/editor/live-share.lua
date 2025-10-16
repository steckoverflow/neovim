return {
	"azratul/live-share.nvim",
	dependencies = {
		"jbyuki/instant.nvim",
	},
	config = function()
		local uv = vim.uv or vim.loop
		local username = (uv and uv.os_get_passwd and uv.os_get_passwd().username)
			or vim.env.USER
			or vim.env.LOGNAME
			or vim.env.USERNAME
			or "unknown"

		vim.g.instant_username = username
		require("live-share").setup({
			port_internal = 8765,
			max_attempts = 40, -- 10 seconds
			service = "serveo.net",
		})
	end,
}
