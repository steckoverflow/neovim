---@class Extras
---@field enable_godot boolean Enable Godot support
---@field debug boolean If true prints configuration when loading

---@class UserConfig
---@field languages string[] List of programming languages to enable in treesitter, mason, debugging
---@field colorscheme string
---@field extras Extras

local M = {}

---@type UserConfig
M.config = {
	colorscheme = "tokyonight",
	languages = {
		"python",
		"golang",
		"web", --javascript, typescript
	},
	extras = {
		enable_godot = false,
		debug = false,
	},
}

return M
