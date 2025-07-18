--  Patch to remove the offending bufload()/filetype detect logic
local wd = require("workspace-diagnostics")

-- replacement for the internal helper
wd._detect_filetype = function(bufnr)
	-- If the buffer is already loaded just read its option
	local ft = vim.bo[bufnr].filetype
	if ft ~= "" then
		return ft
	end

	-- Otherwise use the new non-coroutine API
	return vim.filetype.match({ buf = bufnr }) or ""
end
