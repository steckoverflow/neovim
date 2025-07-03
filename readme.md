# A IKEA/Ingka Neovim flavored Configuration
This is a modular Neovim configuration written in Lua, designed for productivity, code intelligence, and a beautiful UI. It leverages the latest plugin ecosystem and is organized for easy customization.

## Features

- LSP, completion, and code actions
- AI/code assistant integration
- Debugging (DAP) for multiple languages
- Git integration
- Treesitter-based syntax highlighting
- Modern statusline and UI enhancements
- Python virtual environment selector
- Fuzzy finding and search

To disable or enable features based on language edit the lua/config/userconfig.lua file
```lua
---@class Extras
---@field enable_godot boolean Enable Godot support
---@field debug boolean If true prints configuration when loading

---@class UserConfig
---@field languages string[] List of programming languages to enable in treesitter, mason, debugging
---@field extras Extras

local M = {}

---@type UserConfig
M.config = {
	languages = {
		"python",
		"golang",
		"web", --javascript, typescript
	},
	extras = {
		enable_godot = true,
		debug = false,
	},
}

return M
```
