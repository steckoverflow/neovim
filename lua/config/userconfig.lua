--- @module userconfig userconfig is a module to customise what plugins get installed based on user preference.
local M = {}

--- @class Extras
--- @field enable_data_processing_support boolean Enable CSV, TSV based plugin support
--- @field enable_godot boolean Enable Godot support
--- @field debug boolean If true prints configuration when loading

--- @class UserConfig
--- @field languages string[] List of programming languages to enable in treesitter, mason, debugging
--- @field extras Extras

--- @type UserConfig
M.config = {
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
