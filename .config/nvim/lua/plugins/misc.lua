return {
	-- Lazygit
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<CR>", desc = "Open lazy git" },
		},
	},

	-- Ui Select
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},

	-- Codium
	{
		"Exafunction/windsurf.vim",
	},

	-- Vim Maximizer
	{
		"szw/vim-maximizer",
	},

	-- Dressing
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},

	-- Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				notify = {
					enabled = false,
				},
			})
		end,
	},

	-- Todo Commentsc
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo_comments = require("todo-comments")

			-- set keymaps
			local keymap = vim.keymap -- for conciseness

			keymap.set("n", "]t", function()
				todo_comments.jump_next()
			end, { desc = "Next todo comment" })

			keymap.set("n", "[t", function()
				todo_comments.jump_prev()
			end, { desc = "Previous todo comment" })

			todo_comments.setup()
		end,
	},

	-- Auto Session
	{
		"rmagatti/auto-session",
		config = function()
			local auto_session = require("auto-session")

			auto_session.setup({
				auto_restore = false,
				suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
			})
		end,
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
		opts = {
			focus = true,
		},
		cmd = "Trouble",
	},

	-- Surround
	{
		"kylechui/nvim-surround",
		event = { "BufReadPre", "BufNewFile" },
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = true,
	},

	-- Indent Blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},

	-- Java Development
	{
		"mfussenegger/nvim-jdtls",
	},

	-- Comment
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			-- import comment plugin safely
			local comment = require("Comment")

			local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

			-- enable comment
			comment.setup({
				-- for commenting tsx, jsx, svelte, html files
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})
		end,
	},

	-- Neoscroll
	{
		"karb94/neoscroll.nvim",
		opts = {},
		config = function()
			local neoscroll = require("neoscroll")

			neoscroll.setup()

			vim.keymap.set({ "n", "v" }, "<C-d>", function()
				neoscroll.ctrl_d({ duration = 200 })
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("zz", "n", false)
				end, 250) -- Slightly more than ctrl_d's duration
			end, { desc = "Smooth scroll down and center" })

			vim.keymap.set({ "n", "v" }, "<C-u>", function()
				neoscroll.ctrl_u({ duration = 200 })
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("zz", "n", false)
				end, 250)
			end, { desc = "Smooth scroll up and center" })
		end,
	},

	-- Smear Cursor
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},

	-- Fzf Native
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	-- {
	-- 	"nvim-telescope/telescope-live-grep-args.nvim",
	-- },
	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		branch = "v0.6", --recommended as each new version will have breaking changes
		opts = {
			--Config goes here
		},
	},
}
