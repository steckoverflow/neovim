-- local ft = { "go", "python", "lua", "javascript", "typescript", "javascriptreact", "typescriptreact" }
return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Inline virtual text for debugging
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },

		-- Debuggers for different languages
		--NOTE: add the debuggers to ensure_installed in mason-tools.lua
		"mfussenegger/nvim-dap-python",
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio", -- "jbyuki/one-small-step-for-vimkind", -- Neovim
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
			version = "1.*",
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			opts = {
				debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
				adapters = { "chrome", "pwa-node", "pwa-chrome", "pwa-msedge", "pwa-extensionHost", "node-terminal" },
			},
		},
	},
	-- keys = {
	-- 	-- Basic debugging keymaps, feel free to change to your liking!
	-- 	{
	-- 		"<leader>dr",
	-- 		function()
	-- 			require("dap").continue()
	-- 		end,
	-- 		desc = "Run/Continue",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<leader>di",
	-- 		function()
	-- 			require("dap").step_into()
	-- 		end,
	-- 		desc = "Step Into",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<leader>do",
	-- 		function()
	-- 			require("dap").step_over()
	-- 		end,
	-- 		desc = "Step Over",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<leader>dO",
	-- 		function()
	-- 			require("dap").step_out()
	-- 		end,
	-- 		desc = "Step Out",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<leader>db",
	-- 		function()
	-- 			require("dap").toggle_breakpoint()
	-- 		end,
	-- 		desc = "Toggle Breakpoint",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<leader>dB",
	-- 		function()
	-- 			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
	-- 		end,
	-- 		desc = "Set Breakpoint w/condition",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<Leader>dp",
	-- 		function()
	-- 			require("dap").pause()
	-- 		end,
	-- 		desc = "Pause",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<leader>dt",
	-- 		function()
	-- 			require("dap").terminate()
	-- 		end,
	-- 		desc = "Terminate",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<Leader>dR",
	-- 		function()
	-- 			require("dapui").toggle()
	-- 		end,
	-- 		desc = "Last Session Results",
	-- 		ft = ft,
	-- 	},
	-- 	{
	-- 		"<leader>de",
	-- 		function()
	-- 			require("dapui").eval()
	-- 		end,
	-- 		desc = "Eval",
	-- 		ft = ft,
	-- 	},
	-- },
	config = function()
		require("dapui").setup()
		require("dap-go").setup()

		-- Setup for the Python debugger
		-- It's important to call this before setting up the configurations
		require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

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
		}

		-- Godot Debugger Configuration
		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = vim.env.GDScript_Debug_Port or 6006,
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

		-- Install language specific configurations
		local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"

		-- Python
		require("dap-python").setup(mason_packages .. "debugpy/venv/bin/python")

		-- Go
		require("dap-go").setup({
			delve = {
				-- On Windows delve must be run attached or it crashes.
				-- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
				detached = vim.fn.has("win32") == 0,
			},
		})

		-- Neovim
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

		-- JavaScript/TypeScript
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
				-- {
				--   type = "pwa-node",
				--   request = "launch",
				--   name = "Debug Jest Tests",
				--   -- trace = true, -- include debugger info
				--   runtimeExecutable = "node",
				--   runtimeArgs = {
				--     "./node_modules/jest/bin/jest.js",
				--     "--runInBand",
				--   },
				--   rootPath = "${workspaceFolder}",
				--   cwd = "${workspaceFolder}",
				--   console = "integratedTerminal",
				--   internalConsoleOptions = "neverOpen",
				-- },
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
	end,
}
