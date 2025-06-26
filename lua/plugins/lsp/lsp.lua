return { -- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- For LSP actions preview
		{ "aznhe21/actions-preview.nvim", opts = { backend = { "snacks", "nui" } } },

		-- Preview for go to methods
		{
			"rmagatti/goto-preview",
			opts = { default_mappings = true, references = { provider = "snacks" } },
			event = "VeryLazy",
		},

		-- Populates project-wide lsp diagnostcs
		"artemave/workspace-diagnostics.nvim",

		-- Provides keymaps for LSP actions
		"folke/snacks.nvim",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode, lsp)
					mode = mode or "n"
					lsp = lsp == nil and true or lsp
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = lsp and "LSP: " .. desc or desc })
				end

				-- Opens a floating window showing hover information about the symbol under the cursor.
				--  This includes documentation, type information, and other details provided by the LSP.
				map("K", vim.lsp.buf.hover, "Display Hover Information")

				---@module 'snacks'
				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", Snacks.picker.lsp_definitions, "Goto Definition")

				-- Find references for the word under your cursor.
				map("gr", Snacks.picker.lsp_references, "References")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gI", Snacks.picker.lsp_implementations, "Goto Implementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("gy", Snacks.picker.lsp_type_definitions, "Goto Type Definition")

				-- This is not Goto Definition, this is Goto Declaration.
				-- For example, in C this would take you to the header
				-- Many servers do not implement this method
				map("gD", Snacks.picker.lsp_declarations, "Goto Declaration")

				-- Fuzzy find symbols in the workspace
				map("<leader>sS", function()
					Snacks.picker.lsp_workspace_symbols(kind_filter)
				end, "Workspace Symbols", "n", false)

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rv", vim.lsp.buf.rename, "Rename Variable", "n", false)

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", require("actions-preview").code_actions, "Code Action", { "n", "v" }) -- vim.lsp.buf.code_action
			end,
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
