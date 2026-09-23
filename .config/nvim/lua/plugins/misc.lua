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

	-- Todo Comments
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

	-- Java Development
	{
		"mfussenegger/nvim-jdtls",
	},

	-- Context-aware comments for JSX/TSX/Vue (hooks into native gc operator)
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPre", "BufNewFile" },
		opts = { enable_autocmd = false },
		init = function()
			local get_option = vim.filetype.get_option
			vim.filetype.get_option = function(filetype, option)
				return option == "commentstring"
						and require("ts_context_commentstring.internal").calculate_commentstring()
					or get_option(filetype, option)
			end
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
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		-- Completion for `blink.cmp`
		-- dependencies = { "saghen/blink.cmp" },
	},
}
