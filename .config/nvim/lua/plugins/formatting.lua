return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				bash = { "beautysh" },
				css = { "prettierd", "prettier", stop_after_first = true },
				erb = { "htmlbeautifier" },
				go = { "gofumpt" },
				graphql = { "prettierd", "prettier", stop_after_first = true },
				html = { "htmlbeautifier", "prettier", stop_after_first = true },
				java = { "google-java-format" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				kotlin = { "ktlint" },
				liquid = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				proto = { "buf" },
				python = { "isort", "black" },
				ruby = { "standardrb" },
				rust = { "rustfmt" },
				scss = { "prettierd", "prettier", stop_after_first = true },
				svelte = { "prettierd", "prettier", stop_after_first = true },
				sh = { "shellcheck" },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				xml = { "xmllint" },
				yaml = { "yamlfix", "prettier", stop_after_first = true },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		-- Format entire project
		vim.api.nvim_create_user_command("FormatDirectory", function()
			local scan = require("plenary.scandir")
			local conform = require("conform")

			local cwd = vim.fn.getcwd()
			local files = scan.scan_dir(cwd, {
				hidden = false,
				add_dirs = false,
				depth = 5,
				search_pattern = ".*%.%w+$",
			})

			vim.schedule(function()
				for _, file in ipairs(files) do
					local bufnr = vim.fn.bufadd(file)
					vim.fn.bufload(bufnr)

					conform.format({
						bufnr = bufnr,
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})

					vim.api.nvim_buf_call(bufnr, function()
						vim.cmd("write")
					end)
					vim.cmd("bdelete " .. bufnr)
				end
			end)
		end, { desc = "Format all files in the current directory using conform" })

		vim.keymap.set({ "n", "v" }, "<leader>lp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Keymap to format entire project
		vim.keymap.set("n", "<leader>lP", "<cmd>FormatDirectory<CR>", { desc = "Format entire project" })
	end,
}
