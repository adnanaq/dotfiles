return {
	cmd = { "graphql-lsp", "server", "-m", "stream" },
	filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
	root_markers = { ".graphqlrc*", "graphql.config.*", ".graphql.config.*" },
	settings = {
		graphql = {
			validate = true,
			introspection = true,
		},
	},
	single_file_support = true,
	-- workspace_required = true,
}
