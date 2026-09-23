return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data.actions.type == "move" then
					Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
				end
			end,
		})
	end,
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Buffer delete",
			mode = "n",
		},
		{
			"<leader>ba",
			function()
				Snacks.bufdelete.all()
			end,
			desc = "Buffer delete all",
			mode = "n",
		},
		{
			"<leader>bo",
			function()
				Snacks.bufdelete.other()
			end,
			desc = "Buffer delete other",
			mode = "n",
		},
		{
			"<leader>bz",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
			mode = "n",
		},
		-- Picker Keymaps (Replacement for Telescope)
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find Buffers",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent Files",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep Code",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep Word",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>fh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Tags",
		},
		{
			"<leader>fk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>fT",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		{
			"<leader>ft",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Todo Comments",
		},
		{
			"<leader>fgc",
			function()
				Snacks.picker.git_commits()
			end,
			desc = "Git Commits",
		},
		{
			"<leader>fgb",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log (Buffer)",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.lines()
			end,
			desc = "Fuzzily search in current buffer",
		},
	},
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			preset = {
				pick = nil,
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.picker.grep()",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.picker.recent()",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = [[
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]],
			},
			sections = {
				{ section = "header" },
				{
					section = "keys",
					indent = 1,
					padding = 1,
				},
				{ section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 2 },
				{ section = "startup" },
			},
		},
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			ui_select = true, -- Replaces telescope-ui-select
			sources = {
				explorer = {
					hidden = true,
					ignored = true,
				},
			},
			win = {
				input = {
					keys = {
						["<C-t>"] = { "trouble_open", mode = { "n", "i" } },
						["<C-k>"] = { "history_prev", mode = { "i", "n" } },
						["<C-j>"] = { "history_next", mode = { "i", "n" } },
					},
				},
			},
			actions = {
				trouble_open = function(picker)
					require("trouble").open({ mode = "snacks" })
				end,
			},
		},
		notifier = {
			enabled = true,
			style = "fancy",
			date_format = "%R",
			more_format = " ↓ %d lines ",
			timeout = 3000,
		},
		quickfile = { enabled = true },
		scope = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		rename = { enabled = true },
		zen = {
			enabled = true,
			toggles = {
				ufo = true,
				dim = true,
				git_signs = false,
				diagnostics = false,
				line_number = false,
				relative_number = false,
				signcolumn = "no",
				indent = false,
			},
			win = {
				backdrop = {
					transparent = false,
					blend = 99,
				},
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		Snacks.toggle.new({
			id = "ufo",
			name = "Enable/Disable ufo",
			get = function()
				return require("ufo").inspect()
			end,
			set = function(state)
				if state == nil then
					-- require("noice").enable()
					require("ufo").enable()
					vim.o.foldenable = true
					vim.o.foldcolumn = "1"
				else
					-- require("noice").disable()
					require("ufo").disable()
					vim.o.foldenable = false
					vim.o.foldcolumn = "0"
				end
			end,
		})
	end,
}
