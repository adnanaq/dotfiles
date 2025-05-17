return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	{
		"folke/which-key.nvim",
		event = "VimEnter",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function()
			local wk = require("which-key")
			wk.setup({
				-- Your configuration options here
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = false,
					},
					presets = {
						operators = true,
						motions = true,
						text_objects = true,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
				},
				win = {
					border = "rounded",
					padding = { 2, 2 },
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
				},
			})
		end,
	},
}
