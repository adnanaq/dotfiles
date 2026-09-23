return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			win = {
				border = "rounded",
				padding = { 1, 2 },
				row = math.huge,
				col = math.huge,
				no_overlap = false,
			},
			show_help = false,
		},
	},
}
