local globals = require("utils.globals").exec

local vtsls_keymaps = function(g, m)
	m("grp", function()
		g({
			command = "typescript.reloadProjects",
			client = "vtsls",
			message = "TypeScript projects reloaded",
		})
	end, "Reload TS projects")

	-- Go to project config (tsconfig.json)
	m("grc", function()
		g({
			command = "typescript.goToProjectConfig",
			client = "vtsls",
			message = "Opening tsconfig",
		})
	end, "Go to tsconfig")

	-- Select TypeScript version
	m("grv", function()
		g({
			command = "typescript.selectTypeScriptVersion",
			client = "vtsls",
			message = "Select TS version",
		})
	end, "Select TS version")

	-- Open TypeScript server log (for debugging)
	m("grl", function()
		g({
			command = "typescript.openTsServerLog",
			client = "vtsls",
			message = "Opening TS server log",
		})
	end, "Open TS server log")
end

-- Setup document highlighting
local function setup_document_highlight(event, _)
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

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(e)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			if type(mode) == "table" then
				for _, m in ipairs(mode) do
					vim.keymap.set(m, keys, func, { buffer = e.buf, desc = "LSP: " .. desc })
				end
			else
				vim.keymap.set(mode, keys, func, { buffer = 0, desc = "LSP: " .. desc })
			end
		end

		-- Documentation
		map("K", vim.lsp.buf.hover, "Show documentation in hover")

		-- Code navigation and refactoring
		map("gra", vim.lsp.buf.code_action, "Code Actions", { "n", "v" })
		map("grn", vim.lsp.buf.rename, "Rename")
		map("grr", require("telescope.builtin").lsp_references, "Go to References")
		map("grd", require("telescope.builtin").lsp_definitions, "Go to Definitions")
		map("grD", vim.lsp.buf.declaration, "Go to Declaration")
		map("gri", require("telescope.builtin").lsp_implementations, "Go to Implementations")
		map("grt", require("telescope.builtin").lsp_type_definitions, "Type Definitions")
		map("grS", ":LspRestart<CR>", "Restart")
		map("grs", vim.lsp.buf.document_symbol, "Document Symbols")
		map("grk", function()
			vim.lsp.buf.signature_help({ border = "single" })
		end, "Signature Help")
		map("grA", function()
			vim.lsp.buf.code_action({ context = { only = { "source" } } })
		end, "Source Actions", { "n", "v" })

		-- Workspace management
		map("grwa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
		map("grwr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
		map("grwl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List Workspace Folder")
		map("grws", function()
			vim.lsp.buf.workspace_symbol()
		end, "Workspace Symbol")

		-- Get client
		local client = vim.lsp.get_client_by_id(e.data.client_id)

		-- Only set keymaps for vtsls client
		if client and client.name == "vtsls" then
			vtsls_keymaps(globals, map)
		end

		-- Setup document highlighting
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
			setup_document_highlight(e, client)
		end

		-- Toggle Inlay Hints
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
			map("<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = e.buf }))
			end, "Toggle Inlay Hints")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
