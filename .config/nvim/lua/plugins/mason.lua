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

		-- mason_lspconfig.setup({
		-- 	-- list of servers for mason to install
		-- 	ensure_installed = {
		-- 		"basedpyright,
		-- 		"bash-language-server",
		-- 		"dockerfile-language-server",
		-- 		"docker-compose-language-service",
		-- 		"emmet_language_server",
		-- 		"gopls",
		-- 		"graphql-language-service-cli",
		-- 		"html",
		-- 		"jdtls",
		-- 		"lua-language-server",
		-- 		"omnisharp"
		-- 		"tailwindcss-language-server",
		-- 		"ts_ls",
		-- 		"vtsls",
		-- 		"yamlls",
		-- 	},
		-- })

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"ruff",
				"eslint_d",
				"gotests",
				"gofumpt",
				"golines",
				"goimports-reviser",
				"golangci-lint",
				"google-java-format",
				"java-debug-adapter",
				"java-test",
			},
		})
	end,
}
