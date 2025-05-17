return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		
		-- ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
		-- ⟡ Diagnostic & Keybindings
		-- ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
		local function setup_keymaps()
			local opts = function(desc)
				return { noremap = true, silent = true, desc = desc }
			end

			-- Global diagnostic mappings
			vim.keymap.set("n", "<leader>D", function()
				require("telescope.builtin").diagnostics({ bufnr = 0 })
			end, opts("Buffer Diagnostics"))
			
			vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts("Show line diagnostics"))
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Go to Previous Diagnostic"))
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Go to Next Diagnostic"))
		end

		local function setup_diagnostics()
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				virtual_text = {
					prefix = "●", -- Could use "", "●", "▎", or ""
					spacing = 2,
					format = function(diagnostic)
						return string.format("%s: %s", diagnostic.source or "LSP", diagnostic.message)
					end,
				},
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always", -- Show diagnostic source
					header = "",
					prefix = "",
				},
				update_in_insert = false,
				underline = true,
			})
		end

		local function setup_document_highlight(event, client)
			local highlight_augroup = vim.api.nvim_create_augroup("UserLspHighlight", { clear = false })
			
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("UserLspDetach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "UserLspHighlight", buffer = event2.buf })
				end,
			})
		end

		local function setup_lsp_attach_autocmd()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						if type(mode) == "table" then
							for _, m in ipairs(mode) do
								vim.keymap.set(m, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
							end
						else
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end
					end

					-- Documentation
					map("K", vim.lsp.buf.hover, "Show documentation in hover")

					-- Code navigation and refactoring
					map("gra", vim.lsp.buf.code_action, "Code Actions", {"n", "v"})
					map("grn", vim.lsp.buf.rename, "Rename")
					map("grr", require("telescope.builtin").lsp_references, "Go to References")
					map("grd", require("telescope.builtin").lsp_definitions, "Go to Definitions")
					map("grD", vim.lsp.buf.declaration, "Go to Declaration")
					map("gri", require("telescope.builtin").lsp_implementations, "Go to Implementations")
					map("grt", require("telescope.builtin").lsp_type_definitions, "Type Definitions")
					map("grS", ":LspRestart<CR>", "Restart")
					map('grs', vim.lsp.buf.document_symbol, 'Document Symbols')
					map('grk', function()
						vim.lsp.buf.signature_help({ border = 'single' })
					end, 'Signature Help')
					
					-- Workspace management
					map('grwa', vim.lsp.buf.add_workspace_folder, 'Add Workspace Folder')
					map('grwr', vim.lsp.buf.remove_workspace_folder, 'Remove Workspace Folder')
					map('grwl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, 'List Workspace Folder')				
					map("grws", function()
						vim.lsp.buf.workspace_symbol()
					end, "Workspace Symbol")

					-- Get client
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					
					-- Setup document highlighting
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						setup_document_highlight(event, client)
					end

					-- Toggle Inlay Hints
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>ih", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "Toggle Inlay Hints")
					end
				end,
			})
		end

		-- ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
		-- ⟡ Server configurations 
		-- ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
		local function setup_capabilities()
			local lsp_defaults = lspconfig.util.default_config
			lsp_defaults.capabilities = vim.tbl_deep_extend(
				"force", 
				lsp_defaults.capabilities, 
				require("cmp_nvim_lsp").default_capabilities()
			)
			return lsp_defaults.capabilities
		end

		local function setup_lua_ls()
			local runtime_path = vim.split(package.path, ";")
			table.insert(runtime_path, "lua/?.lua")
			table.insert(runtime_path, "lua/?/init.lua")
			
			lspconfig.lua_ls.setup({
				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					})
					client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
				end,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
						hint = {
							enable = true,
							setType = true,
							paramType = true,
							paramName = "All",
							semicolon = "Disable",
						}
					},
				},
			})
		end

		local function setup_servers()
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ Golang - Go language support                    --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.gopls.setup({
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = lspconfig.util.root_pattern("go.mod", "go.work", ".git"),
				settings = {
					gopls = {
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
						},
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						experimentalPostfixCompletions = true,
						gofumpt = true,
						staticcheck = true,
						usePlaceholders = true,
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

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ OmniSharp - C# language support                 --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.omnisharp.setup({
				cmd = { "OmniSharp" },
			})

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ Lua - Lua language support                      --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			setup_lua_ls()

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ TypeScript - TS/JS language support             --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.ts_ls.setup({
				init_options = {
					preferences = {
						includeInlayParameterNameHints = 'all',
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
						importModuleSpecifierPreference = 'non-relative',
					},
				},
				-- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
	            -- on_attach = function(client, bufnr)
				--     client.server_capabilities.document_formatting = false
				--     client.server_capabilities.document_range_formatting = false
				--     on_attach(client, bufnr)
				-- end,
			})

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ Python - Python language support                --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.pyright.setup({})
			lspconfig.ruff.setup({})

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ GraphQL - GraphQL schema and operations         --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.graphql.setup({
				filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
			})
			
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ Svelte - Svelte framework support               --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.svelte.setup({
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			})

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ Emmet - HTML/CSS abbreviation support           --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.emmet_language_server.setup({
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
			})

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ HTML - HTML, CSS, and JavaScript support        --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.html.setup({
				settings = {
					css = {
						lint = {
							validProperties = {},
						},
					},
				},
			})

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ YAML - YAML language support                    --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.yamlls.setup({
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
						editor = {
							tabSize = 2,
						},
						schemaStore = {
							enable = true,
						},
					},
					editor = {
						tabSize = 2,
					},
				},
			})

			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ Rust - Rust language support                    --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.rust_analyzer.setup({})

			
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			-- ➤ Tailwind CSS - Utility-first CSS framework      --
			-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ --
			lspconfig.tailwindcss.setup({
				settings = {
					tailwindCSS = {
						classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
						includeLanguages = {
							eelixir = 'html-eex',
							eruby = 'erb',
							htmlangular = 'html',
							templ = 'html',
						},
						lint = {
							cssConflict = 'warning',
							invalidApply = 'error',
							invalidConfigPath = 'error',
							invalidScreen = 'error',
							invalidTailwindDirective = 'error',
							invalidVariant = 'error',
							recommendedVariantOrder = 'warning',
						},
						validate = true,
					},
				},
			})
		end

		-- ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
		-- ⟡ Initialize
		-- ✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦✦
		local function init()
			setup_keymaps()
			setup_diagnostics()
			setup_lsp_attach_autocmd()
			setup_capabilities()
			setup_servers()
		end

		init()
	end,
}
