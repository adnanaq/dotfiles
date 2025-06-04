return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,

	opts = {
		-- provider = "openai",
		providers = {
			openai = {
				model = "gpt-4.1", -- chat: gpt-4.1, Reasoning: o4-mini, o3
			},
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514", -- Chat: Sonnet, Reasoning: Opus
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 4096,
				},
			},
		},
	},

	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'

		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},

		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
