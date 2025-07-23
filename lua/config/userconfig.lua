--- @module userconfig userconfig is a module to customise what plugins get installed based on user preference.
local M = {}

---@class UserConfig
---@field languages string[] List of programming languages to enable in treesitter, mason, debugging
---@field colorscheme string
---@field extras Extras

--- @class Extras
--- @field enable_data_processing_support boolean Enable CSV, TSV based plugin support
--- @field enable_godot boolean Enable Godot support
--- @field debug boolean If true prints configuration when loading

--- @type UserConfig
M.config = {
	colorscheme = "tokyonight",
	languages = {
		"python",
		"golang",
		"web", --javascript, typescript
		"sql",
	},
	---@type Extras
	extras = {
		enable_data_processing_support = true,
		enable_godot = false,
		debug = false,
	},
}

return M
