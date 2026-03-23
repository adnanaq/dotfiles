return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	single_file_support = true,
}
