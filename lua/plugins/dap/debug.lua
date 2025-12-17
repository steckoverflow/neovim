local M = {}

M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui", -- Creates a beautiful debugger UI
		"theHamsta/nvim-dap-virtual-text", -- Inline virtual text for debugging
		"nvim-neotest/nvim-nio",
	},
}
if vim.tbl_contains(_G["userconfig"].languages, "python") then
	M.dependencies = vim.list_extend(M.dependencies, {
		"mfussenegger/nvim-dap-python",
	})
end
if vim.tbl_contains(_G["userconfig"].languages, "golang") then
	M.dependencies = vim.list_extend(M.dependencies, {
		"leoluz/nvim-dap-go",
	})
end
if vim.tbl_contains(_G["userconfig"].languages, "web") then
	M.dependencies = vim.list_extend(M.dependencies, {
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			version = "1.*",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			opts = {
				debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
				adapters = {
					"chrome",
					"pwa-node",
					"pwa-chrome",
					"pwa-msedge",
					"pwa-extensionHost",
					"node-terminal",
				},
			},
		},
	})
end

M.config = function()
	require("dapui").setup()
	local dap, dapui = require("dap"), require("dapui")

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end

	if vim.tbl_contains(_G["userconfig"].languages, "python") then
		local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"
		require("dap-python").setup(mason_packages .. "debugpy/venv/bin/python")
		-- Python Debugger Configuration
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}", -- This will use the current file
				pythonPath = function()
					-- You can customize this to point to your project's virtual environment
					return vim.fn.exepath("python")
				end,
			},
			{
				type = "python",
				request = "launch",
				name = "Launch file (w external code)",
				program = "${file}", -- This will use the current file
				pythonPath = function()
					-- You can customize this to point to your project's virtual environment
					return vim.fn.exepath("python")
				end,
				justMyCode = false,
			},
			{
				type = "python",
				request = "launch",
				name = "Launch file with pytest",
				module = "pytest",
				args = { "${file}" },
				justMyCode = false,
				pythonPath = function()
					-- You can customize this to point to your project's virtual environment
					return vim.fn.exepath("python")
				end,
			},
		}
	end
	if vim.tbl_contains(_G["userconfig"].languages, "golang") then
		require("dap-go").setup()
	end

	if vim.tbl_contains(_G["userconfig"].languages, "web") then
		for _, language in ipairs({ "typescript", "javascript", "javascriptreact", "typescriptreact" }) do
			require("dap").configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch & Debug Chrome",
					url = function()
						local co = coroutine.running()
						return coroutine.create(function()
							vim.ui.input({
								prompt = "Enter URL: ",
								default = "http://localhost:3000",
							}, function(url)
								if url == nil or url == "" then
									return
								else
									coroutine.resume(co, url)
								end
							end)
						end)
					end,
					webRoot = vim.fn.getcwd(),
					protocol = "inspector",
					sourceMaps = true,
					userDataDir = false,
				},
				-- Divider for the launch.json derived configs
				{
					name = "----- ↓ launch.json configs ↓ -----",
					type = "",
					request = "launch",
				},
			}
		end
	end

	if _G["userconfig"].extras.enable_godot then
		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = 6006,
		}
		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}
	end

	-- Neovim and Lua is always here.
	dap.configurations.lua = {
		{
			type = "nlua",
			request = "attach",
			name = "Attach to running Neovim instance",
		},
	}
	dap.adapters.nlua = function(callback, config)
		callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
	end
	vim.api.nvim_create_user_command("NeovimDebugStart", function()
		require("osv").launch({ port = 8086 })
	end, {})
end

if _G["userconfig"].extras.debug then
	vim.notify("Debug Config:\n" .. vim.inspect(M), vim.log.levels.DEBUG)
end

return M
