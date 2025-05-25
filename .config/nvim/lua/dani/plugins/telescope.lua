return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function(prompt_bufnr)
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = "  ",
				multi_icon = "",
				path_display = { "smart" },
				layout_config = {
					horizontal = {
						preview_width = 0.6,
					},
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
					},
				},
				file_ignore_patterns = { "node_modules" },
			},
		})

		telescope.load_extension("fzf")
		-- telescope.load_extension("noice")
		telescope.load_extension("ui-select")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
		keymap.set("n", "<leader>fc", builtin.live_grep, { desc = "Find Grep code" })
		keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Find Symbols" })
		keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under Cursor" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
		-- keymap.set(
		-- 	"n",
		-- 	"<leader>fc",
		-- 	'<cmd>lua require("telescope.builtin").live_grep({ glob_pattern = "!{spec,test}/**,!*_test.*"})<CR>',
		-- 	{ desc = "Live Grep Code" }
		-- )
		keymap.set("n", "<leader>fgc", function()
			builtin.git_commits(require("telescope.themes").get_dropdown({
				winblend = 10,
				layout_config = { width = 0.7 },
			}))
		end, { desc = "Search Git Commits" })
		keymap.set("n", "<leader>fgb", function()
			builtin.git_bcommits(require("telescope.themes").get_dropdown({
				winblend = 10,
				layout_config = { width = 0.7 },
			}))
		end, { desc = "Search Git Commits for Buffer" })
		keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
				layout_config = { width = 0.7 },
			}))
		end, { desc = "[/] Fuzzily Buffer search" })
	end,
}
