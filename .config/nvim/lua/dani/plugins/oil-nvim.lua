return {
	"stevearc/oil.nvim",
	opts = {},
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		local oil = require("oil")
		oil.setup({
			default_file_explorer = true,
			delete_to_trash = false,
			skip_confirm_for_simple_edits = true,
			view_options = {
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == ".git" or name == ".."
				end,
				open_url = function(url)
					os.execute('explorer.exe "' .. url:gsub('"', '\\"') .. '"')
				end,
			},
			win_options = {
				wrap = true,
				winblend = 0,
			},
			float = {
				padding = 2,
				max_width = 60,
				max_height = 0,
				border = "rounded",
			},
		})
	end,
}
