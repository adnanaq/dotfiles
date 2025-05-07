return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

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

     -- Keymap to format entire project
     vim.keymap.set("n", "<leader>mP", "<cmd>FormatDirectory<CR>", { desc = "Format entire project" })
	end,
}
