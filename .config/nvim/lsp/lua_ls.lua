return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
					-- unpack(vim.api.nvim_get_runtime_file("", true)),
				},
			},
			completion = { callSnippet = "Replace" },
			hint = {
				enable = true,
				setType = true,
				paramType = true,
				paramName = "All",
				semicolon = "Disable",
			},
		},
	},
}
