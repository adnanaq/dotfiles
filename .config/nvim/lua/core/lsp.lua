vim.lsp.enable({
	"basedpyright",
	"bash-language-server",
	"docker_compose_language_server",
	"dockerfile-language-server",
	"emmet_language_server",
	"gopls",
	"graphql-language-service-cli",
	"html",
	"kotlin_lsp",
	"lua-language-server",
	"tailwindcss-language-server",
	"ts_ls",
	"vtsls",
	"yamlls",
})

vim.diagnostic.config({
	virtual_lines = true,
	-- 	virtual_text = {
	-- 		prefix = "●", -- Could use "", "●", "▎", or ""
	-- 		spacing = 2,
	-- 		format = function(diagnostic)
	-- 			return string.format("%s: %s", diagnostic.source or "LSP", diagnostic.message)
	-- 		end,
	-- 	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
