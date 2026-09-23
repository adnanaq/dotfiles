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

		-- Explicit list of servers for your active languages
		local lsp_servers = {
			"lua_ls",
			"rust_analyzer",
			"ty",
			"ruff",
			"vtsls", -- Optimized TypeScript/JS/React/Vue
			"html",
			"cssls",
			"tailwindcss",
			"emmet_language_server",
			"jdtls", -- Java (handled by nvim-jdtls ftplugin)
			"bashls",
			"jsonls",
			"yamlls",
			"dockerls",
			"docker_compose_language_service",
			"graphql",
		}

		mason_lspconfig.setup({
			ensure_installed = lsp_servers,
			automatic_enable = false, -- We manage vim.lsp.enable() explicitly in core/lsp.lua
		})

		-- Tools (linters/formatters/DAP) strictly for your tech stack
		mason_tool_installer.setup({
			ensure_installed = {
				-- Lua
				"stylua",

				-- Python tools
				"ruff",
				"debugpy",

				-- Web/JS/TS/React/Vue/Angular
				"prettierd",
				"js-debug-adapter",

				-- Java tools
				"google-java-format",
				"java-debug-adapter",
				"java-test",

				-- Shell
				"shellcheck",
				"beautysh",
			},
		})
	end,
}
