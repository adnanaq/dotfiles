return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	single_file_support = true,
	settings = {
		yaml = {
			validate = true,
			hover = true,
			completion = true,
			format = {
				enable = true,
				singleQuote = true,
				bracketSpacing = true,
			},
			schemaStore = {
				enable = true,
			},
			schemas = {
				kubernetes = "k8s/**/*.{yaml}",
			},
		},
	},
}
