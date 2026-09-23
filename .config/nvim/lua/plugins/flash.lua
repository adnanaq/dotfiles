return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = { enabled = false }, -- don't hijack / search
			char = { enabled = false },   -- don't hijack f/t/F/T
		},
	},
	keys = {
		{ "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash jump" },
		{ "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash treesitter" },
		{ "r", function() require("flash").remote() end, mode = "o", desc = "Remote flash" },
		{ "R", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Flash treesitter search" },
	},
}
