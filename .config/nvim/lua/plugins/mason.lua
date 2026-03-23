return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- Helper: Check if a command exists in PATH
		local function has_cmd(cmd)
			return vim.fn.executable(cmd) == 1
		end

		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- LSP servers with conditional installation
		local lsp_servers = {
			-- Always install (no runtime dependencies)
			"bashls",
			"jsonls",
			"yamlls",
		}

		-- Conditionally add LSP servers based on available runtimes
		if has_cmd("docker") then
			table.insert(lsp_servers, "dockerls")
			table.insert(lsp_servers, "docker_compose_language_service")
		end

		if has_cmd("node") then
			table.insert(lsp_servers, "emmet_language_server")
			table.insert(lsp_servers, "graphql")
			table.insert(lsp_servers, "tailwindcss")
			table.insert(lsp_servers, "vtsls")
		end

		if has_cmd("go") then
			table.insert(lsp_servers, "gopls")
		end

		if has_cmd("java") then
			table.insert(lsp_servers, "jdtls")
		end

		if has_cmd("kotlin") then
			table.insert(lsp_servers, "kotlin_lsp")
		end

		if has_cmd("dotnet") then
			table.insert(lsp_servers, "omnisharp")
		end

		if has_cmd("rustc") then
			table.insert(lsp_servers, "rust_analyzer")
		end

		mason_lspconfig.setup({
			ensure_installed = lsp_servers,
		})

		-- Tools (linters/formatters/DAP) with conditional installation
		-- Note: mason-tool-installer DOES support condition parameter
		mason_tool_installer.setup({
			ensure_installed = {
				-- Lua (always available in Neovim)
				"stylua",

				-- Go tools
				{
					"golangci-lint",
					condition = function()
						return has_cmd("go")
					end,
				},
				{
					"gofumpt",
					condition = function()
						return has_cmd("go")
					end,
				},
				{
					"goimports-reviser",
					condition = function()
						return has_cmd("go")
					end,
				},
				{
					"gotests",
					condition = function()
						return has_cmd("go")
					end,
				},
				{
					"delve",
					condition = function()
						return has_cmd("go")
					end,
				},
				{
					"go-debug-adapter",
					condition = function()
						return has_cmd("go")
					end,
				},

				-- Python tools
				{
					"ruff",
					condition = function()
						return has_cmd("python3") or has_cmd("python")
					end,
				},
				{
					"ty",
					condition = function()
						return has_cmd("python3") or has_cmd("python")
					end,
				},

				-- Node.js tools
				{
					"eslint_d",
					condition = function()
						return has_cmd("node")
					end,
				},
				{
					"prettier",
					condition = function()
						return has_cmd("node")
					end,
				},

				-- Java tools
				{
					"google-java-format",
					condition = function()
						return has_cmd("java")
					end,
				},
				{
					"ktlint",
					condition = function()
						return has_cmd("kotlin") or has_cmd("kotlind")
					end,
				},
				{
					"java-debug-adapter",
					condition = function()
						return has_cmd("java")
					end,
				},
				{
					"java-test",
					condition = function()
						return has_cmd("java")
					end,
				},
			},
		})
	end,
}
