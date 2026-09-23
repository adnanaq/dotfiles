-- LSP Configurations (v0.11+ Native)
-- Ensure Mason binaries are in the PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH

-- Lua
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	-- Make lua_ls aware of the Neovim runtime (`vim` global, completion, types).
	-- Skipped for projects with their own .luarc.json (except the Neovim config itself).
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

-- TypeScript/JS/Vue
vim.lsp.config("vtsls", {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	settings = {
		vtsls = {
			autoUseWorkspaceTsdk = true,
			enableMoveToFileCodeAction = true,
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
			},
		},
		javascript = {
			updateImportsOnFileMove = { enabled = "always" },
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
			},
		},
	},
})

-- Python: type checking + navigation (definitions, rename, references)
vim.lsp.config("ty", {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
})

-- Python: lint + format
vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	on_attach = function(client)
		-- ty handles hover; disable ruff's hover to avoid duplicates
		client.server_capabilities.hoverProvider = false
	end,
})

-- Rust
vim.lsp.config("rust_analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "rust-project.json" },
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
			},
		},
	},
})

-- HTML
vim.lsp.config("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
})

-- CSS
vim.lsp.config("cssls", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
})

-- Bash/Shell
vim.lsp.config("bashls", {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
	root_markers = { ".git" },
})

-- JSON
vim.lsp.config("jsonls", {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package.json", ".git" },
})

-- YAML
vim.lsp.config("yamlls", {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".git" },
	settings = {
		yaml = { validate = true, hover = true, completion = true },
	},
})

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_markers = {
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
		"postcss.config.js",
	},
})

-- Emmet
vim.lsp.config("emmet_language_server", {
	cmd = { "emmet-language-server", "--stdio" },
	filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" },
	root_markers = { ".git" },
})

-- Docker
vim.lsp.config("dockerls", {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile", ".git" },
})

vim.lsp.config("docker_compose_language_service", {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
})

-- GraphQL
vim.lsp.config("graphql", {
	cmd = { "graphql-lsp", "server", "-m", "stream" },
	filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
	root_markers = { ".graphqlrc*", "graphql.config.*", ".graphql.config.*", "package.json" },
})

-- Go
vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work", ".git" },
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
			completeUnimported = true,
			experimentalPostfixCompletions = true,
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
			analyses = {
				nilness = true,
				unusedparams = true,
				unusedwrite = true,
				useany = true,
				unreachable = true,
				modernize = true,
				stylecheck = true,
				appends = true,
				asmdecl = true,
				assign = true,
				atomic = true,
				bools = true,
				buildtag = true,
				cgocall = true,
				composite = true,
				contextcheck = true,
				deba = true,
				atomicalign = true,
				composites = true,
				copylocks = true,
				deepequalerrors = true,
				defers = true,
				deprecated = true,
				directive = true,
				embed = true,
				errorsas = true,
				fillreturns = true,
				framepointer = true,
				gofix = true,
				hostport = true,
				infertypeargs = true,
				lostcancel = true,
				httpresponse = true,
				ifaceassert = true,
				loopclosure = true,
				nilfunc = true,
				nonewvars = true,
				noresultvalues = true,
				printf = true,
				shadow = true,
				shift = true,
				sigchanyzer = true,
				simplifycompositelit = true,
				simplifyrange = true,
				simplifyslice = true,
				slog = true,
				sortslice = true,
				stdmethods = true,
				stdversion = true,
				stringintconv = true,
				structtag = true,
				testinggoroutine = true,
				tests = true,
				timeformat = true,
				unmarshal = true,
				unsafeptr = true,
				unusedfunc = true,
				unusedresult = true,
				waitgroup = true,
				yield = true,
				unusedvariable = true,
			},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			codelenses = {
				gc_details = false,
				generate = true,
				regenerate_cgo = true,
				run_govulncheck = true,
				test = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = true,
			},
		},
	},
})

-- Enable all configured servers
vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"ty",
	"ruff",
	"rust_analyzer",
	"html",
	"cssls",
	"bashls",
	"jsonls",
	"yamlls",
	"tailwindcss",
	"emmet_language_server",
	"dockerls",
	"docker_compose_language_service",
	"graphql",
	"gopls",
})

vim.lsp.codelens.enable()

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
