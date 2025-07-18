local M = {}

M = {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"artemave/workspace-diagnostics.nvim",
			config = function()
				require("patches.workspace_diagnostics")
			end,
		}, -- Populates project-wide lsp diagnostcs
		"folke/snacks.nvim", -- Provides keymaps for LSP actions
	},
}

M.config = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end
			map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if
				client
				and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
			then
				local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
					end,
				})
			end
			if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	local servers = {
		-- Default LSPs
		mason = {
			stylua = {},
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
		},
		-- This table contains config for all language servers that are *not* installed via Mason.
		-- Structure is identical to the mason table from above.
		others = {},
	}

	-- Add Golang-related servers if Golang is enabled
	if vim.tbl_contains(_G["userconfig"].languages, "golang") then
		servers.mason.gopls = {}
		servers.mason.delve = {}
		servers.mason.gomodifytags = {}
		servers.mason.gotests = {}
		servers.mason.iferr = {}
		servers.mason.impl = {}
		servers.mason.goimports = {}
	end

	-- Add Python-related servers if Python is enabled
	if vim.tbl_contains(_G["userconfig"].languages, "python") then
		servers.mason.ruff = {}
		servers.mason.basedpyright = {
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
		}
		servers.mason.debugpy = {}
	end

	if vim.tbl_contains(_G["userconfig"].languages, "web") then
		servers.mason.tailwindcss = {}
		servers.mason.cssls = {}
		servers.mason.svelte = {}
	end

	if _G["userconfig"].extras.enable_godot then
		servers.mason.gdtoolkit = {}
		require("lspconfig")["gdscript"].setup({
			name = "godot",
			cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
		})
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

	local ensure_installed = vim.tbl_keys(servers.mason or {})
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	require("mason-lspconfig").setup({
		ensure_installed = {},
		automatic_installation = false,
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

if _G["userconfig"].extras.debug then
	print("\n\n\n LSP Config \n\n\n")
	print(vim.inspect(M))
end

return M
