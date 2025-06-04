return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim" },
	version = "1.*",
	config = function()
		require("blink.cmp").setup({
			keymap = { preset = "default" },
			appearance = {
				nerd_font_variant = "mono",
			},

			cmdline = {
				completion = {
					ghost_text = { enabled = true },
				},
			},

			completion = {
				accept = { auto_brackets = { enabled = true } },
				ghost_text = { enabled = true, show_with_menu = false },

				documentation = {
					auto_show = false,
					auto_show_delay_ms = 100,
					treesitter_highlighting = true,
					window = { border = "rounded" },
				},

				menu = {
					border = "rounded",
					cmdline_position = function()
						if vim.g.ui_cmdline_pos ~= nil then
							local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
							return { pos[1] - 1, pos[2] }
						end
						local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
						return { vim.o.lines - height, 0 }
					end,
					draw = {
						-- treesitter = { "lsp" },
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
							{ "source_name" },
						},
					},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
			-- signature = { enabled = true, window = { border = "rounded" } },

			snippets = { preset = "luasnip" },

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						min_keyword_length = 0,
						score_offset = 100,
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						min_keyword_length = 0,
						score_offset = 60,
					},
					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						min_keyword_length = 2,
						score_offset = 80,
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 5,
						max_items = 5,
						score_offset = 50,
					},
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
				},
			},
		})
	end,
}
