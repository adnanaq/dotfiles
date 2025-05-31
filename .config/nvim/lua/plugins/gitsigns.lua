return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bufnr)
			local wk = require("which-key")
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end

			-- Navigation
			map("n", "]h", gs.next_hunk, "Next Hunk")
			map("n", "[h", gs.prev_hunk, "Prev Hunk")

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")

			-- Actions
			wk.add({
				{ "<leader>h", group = "Gitsigns" },
				{ "<leader>hs", gs.stage_hunk, desc = "Stage hunk", buffer = bufnr, mode = "n" },
				{ "<leader>hp", gs.preview_hunk, desc = "Preview hunk", buffer = bufnr, mode = "n" },
				{ "<leader>hr", gs.reset_hunk, desc = "Reset hunk", buffer = bufnr, mode = "n" },
				{
					"<leader>hs",
					function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "Stage hunk",
					buffer = bufnr,
					mode = "v",
				},
				{
					"<leader>hr",
					function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "Reset hunk",
					buffer = bufnr,
					mode = "v",
				},
				{ "<leader>hS", gs.stage_buffer, desc = "Stage buffer", buffer = bufnr, mode = "n" },
				{ "<leader>hR", gs.reset_buffer, desc = "Reset buffer", buffer = bufnr, mode = "n" },
				{ "<leader>hu", gs.undo_stage_hunk, desc = "Undo stage hunk", buffer = bufnr, mode = "n" },
				{
					"<leader>hb",
					function()
						gs.blame_line({ full = true })
					end,
					desc = "Blame line",
					buffer = bufnr,
					mode = "n",
				},
				{ "<leader>hB", gs.toggle_current_line_blame, desc = "Toggle line blame", buffer = bufnr, mode = "n" },
				{ "<leader>hd", gs.diffthis, desc = "Diff this", buffer = bufnr, mode = "n" },
				{
					"<leader>hD",
					function()
						gs.diffthis("~")
					end,
					desc = "Diff this ~",
					buffer = bufnr,
					mode = "n",
				},
			})
		end,
	},
}
