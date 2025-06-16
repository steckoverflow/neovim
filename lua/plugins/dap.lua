return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
			"nvim-neotest/nvim-nio",
		},
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

			-- Keymaps for debugging
			vim.keymap.set("n", "<leader>dui", dapui.toggle, { desc = "Toggle DAP UI" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
			vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
		end,
	},
}
