return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Populates project-wide lsp diagnostcs
		"artemave/workspace-diagnostics.nvim",

		-- Provides keymaps for LSP actions
		"folke/snacks.nvim",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		})

		local servers = {
			mason = {
				bashls = {},
				dockerls = {},
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							hint = { enable = true },
							telemetry = { enable = false },
							diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				ruff = {},
				basedpyright = {
					before_init = function(_, c)
						if not c.settings then
							c.settings = {}
						end
						if not c.settings.python then
							c.settings.python = {}
						end
						c.settings.python.pythonPath = vim.fn.exepath("python")
						c.settings.python.extraPaths = { vim.fn.getcwd() }
					end,
					settings = {
						basedpyright = {
							analysis = {
								typeCheckingMode = "basic",
								autoImportCompletions = true,
								diagnosticSeverityOverrides = {
									reportUnusedImport = "information",
									reportUnusedFunction = "information",
									reportUnusedVariable = "information",
									reportGeneralTypeIssues = "none",
									reportOptionalMemberAccess = "none",
									reportOptionalSubscript = "none",
									reportPrivateImportUsage = "none",
								},
							},
						},
					},
				},
				debugpy = {},
				gopls = {},
				delve = {},
				gomodifytags = {},
				gotests = {},
				iferr = {},
				impl = {},
				goimports = {},
				gdscript = {
					cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
					filetypes = { "gd", "gdscript", "gdscript3" },
					root_markers = { ".git", "gdscript.toml" },
					single_file_support = true,
				},
			},
			-- This table contains config for all language servers that are *not* installed via Mason.
			-- Structure is identical to the mason table from above.
			others = {},
		}

		---@param command string?
		local function skip_lsp(command)
			return not (command == nil or vim.fn.executable(command) == 1)
		end

		-- Configure Servers
		vim.lsp.enable("ts_ls", false) -- typescript-tools is used instead
		for server, config in pairs(vim.tbl_extend("keep", servers.mason, servers.others)) do
			local command = config.command
			config.command = nil
			if skip_lsp(command) then
				for cat, _ in pairs(servers) do
					servers[cat][server] = nil
				end
			elseif not vim.tbl_isempty(config) then
				vim.lsp.config(server, config)
			end
		end

		-- Manually run vim.lsp.enable for all language servers that are *not* installed via Mason
		if not vim.tbl_isempty(servers.others) then
			vim.lsp.enable(vim.tbl_keys(servers.others))
		end

		-- add workspace-diagnostics to all LSPs
		vim.lsp.config("*", {
			on_attach = function(client, bufnr)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			end,
		})

		-- Grab the list of servers and tools to install and add them to ensure_installed
		local ensure_installed = vim.tbl_keys(servers.mason or {})
		-- local tools = require("kickstart.mason-tools")
		-- vim.list_extend(ensure_installed, tools)
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	end,
}
