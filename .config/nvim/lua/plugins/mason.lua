return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
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

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"basedpyright",
				"bashls",
				"dockerls",
				"docker_compose_language_service",
				"emmet_language_server",
				"gopls",
				"graphql",
				--"html",
				"jdtls",
				"kotlin_lsp",
				"lua_ls",
				"omnisharp",
				"rust_analyzer",
				"tailwindcss",
				-- "ts_ls",
				"vtsls",
				"yamlls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				-- Linters
				"eslint_d",
				"golangci-lint",
				-- Formatter and Linter
				"ruff",
				"ktlint",
				-- Formatter
				"black",
				"google-java-format",
				"gofumpt",
				"goimports-reviser",
				"gotests",
				"isort",
				"prettier",
				"stylua",
				-- DAP
				"delve",
				"go-debug-adapter",
				"java-debug-adapter",
				"java-test",
			},
		})
	end,
}
