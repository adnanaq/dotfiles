return {
	-- TokyoNight Theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local transparent = false -- set to true if you would like to enable transparency

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,
				styles = {
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
			})
		end,
	},

	-- OneDark Theme
	{
		"navarasu/onedark.nvim",
		lazy = false,
		config = function()
			require("onedark").setup({
				style = "warmer",
				code_style = {
					comments = "italic",
					keywords = "italic",
					functions = "bold",
				},
			})
		end,
	},

	-- Oceanic Next Theme
	{
		"mhartington/oceanic-next",
		lazy = false,
	},

	-- Catppuccin Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false,
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false,
				no_bold = false,
				no_underline = false,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
				},
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},

	{ "Shatur/neovim-ayu" },

	{ "rebelot/kanagawa.nvim" },

	-- Theme Manager Configuration
	{
		"folke/tokyonight.nvim", -- We use this as the base plugin for our theme manager
		name = "theme-manager",
		priority = 1001, -- Higher priority to ensure it loads after themes
		config = function()
			-- Define all available themes
			local themes = {
				{
					name = "TokyoNight Night",
					colorscheme = "tokyonight-night",
					lualinescheme = "tokyonight-night",
				},
				{
					name = "TokyoNight Storm",
					colorscheme = "tokyonight-storm",
					lualinescheme = "tokyonight-storm",
				},
				{
					name = "TokyoNight Day",
					colorscheme = "tokyonight-day",
					lualinescheme = "tokyonight-day",
				},
				{
					name = "TokyoNight Moon",
					colorscheme = "tokyonight-moon",
					lualinescheme = "tokyonight-moon",
				},
				{
					name = "OneDark",
					colorscheme = "onedark",
					lualinescheme = "onedark",
				},
				{
					name = "Oceanic Next",
					colorscheme = "OceanicNext",
					lualinescheme = "OceanicNext",
				},
				{
					name = "Catppuccin Latte",
					colorscheme = "catppuccin-latte",
					lualinescheme = "catppuccin-latte",
				},
				{
					name = "Catppuccin Frappe",
					colorscheme = "catppuccin-frappe",
					lualinescheme = "catppuccin-frappe",
				},
				{
					name = "Catppuccin Macchiato",
					colorscheme = "catppuccin-macchiato",
					lualinescheme = "catppuccin-macchiato",
				},
				{
					name = "Catppuccin Mocha",
					colorscheme = "catppuccin-mocha",
					lualinescheme = "catppuccin-mocha",
				},
				{
					name = "Rose Pine",
					colorscheme = "rose-pine",
					lualinescheme = "rose-pine",
				},
				{
					name = "Rose Pine Main",
					colorscheme = "rose-pine-main",
					lualinescheme = "rose-pine",
				},
				{
					name = "Rose Pine Moon",
					colorscheme = "rose-pine-moon",
					lualinescheme = "rose-pine",
				},
				{
					name = "Rose Pine Moon",
					colorscheme = "rose-pine-dawn",
					lualinescheme = "rose-pine",
				},
				{
					name = "Ayu Dark",
					colorscheme = "ayu-dark",
					lualinescheme = "ayu",
				},
				{
					name = "Ayu Light",
					colorscheme = "ayu-light",
					lualinescheme = "ayu",
				},
				{
					name = "Ayu Mirage",
					colorscheme = "ayu-mirage",
					lualinescheme = "ayu",
				},
				{
					name = "Kanagawa Wave",
					colorscheme = "kanagawa-wave",
					lualinescheme = "kanagawa",
				},
				{
					name = "Kanagawa Dragon",
					colorscheme = "kanagawa-dragon",
					lualinescheme = "kanagawa",
				},
				{
					name = "Kanagawa Lotus",
					colorscheme = "kanagawa-lotus",
					lualinescheme = "kanagawa",
				},
			}

			-- Current theme index
			local current_theme_index = 1

			-- Function to save current theme to a simple cache file
			local function save_theme(theme_index)
				vim.g.persistent_theme_index = theme_index
				-- Simple one-liner to save theme
				os.execute(string.format('echo "%d" > %s/.nvim_theme', theme_index, os.getenv("HOME")))
			end

			-- Function to load saved theme
			local function load_saved_theme()
				-- First try session variable
				local saved_index = vim.g.persistent_theme_index
				if saved_index and saved_index >= 1 and saved_index <= #themes then
					return saved_index
				end

				-- Try to read from cache file
				local home = os.getenv("HOME")
				local handle = io.popen(string.format("cat %s/.nvim_theme 2>/dev/null", home))
				if handle then
					local result = handle:read("*a")
					handle:close()
					local theme_index = tonumber(result)
					if theme_index and theme_index >= 1 and theme_index <= #themes then
						return theme_index
					end
				end

				return 9 -- Default
			end

			-- Function to apply a theme
			local function apply_theme(theme)
				-- Apply colorscheme
				vim.cmd.colorscheme(theme.colorscheme)

				-- Update lualine if available
				local ok, _ = pcall(require, "lualine")
				if ok then
					require("lualine").setup({
						options = {
							theme = theme.lualinescheme,
						},
					})
				end

				-- Notify user
				vim.notify("Applied theme: " .. theme.name, vim.log.levels.INFO)
			end

			-- Function to toggle to next theme
			function ToggleTheme()
				current_theme_index = current_theme_index % #themes + 1
				apply_theme(themes[current_theme_index])
				save_theme(current_theme_index)
			end

			-- Function to toggle to previous theme
			function ToggleThemePrev()
				current_theme_index = current_theme_index - 1
				if current_theme_index < 1 then
					current_theme_index = #themes
				end
				apply_theme(themes[current_theme_index])
				save_theme(current_theme_index)
			end

			-- Function to select specific theme by name
			function SelectTheme(theme_name)
				for i, theme in ipairs(themes) do
					if theme.name:lower():find(theme_name:lower()) then
						current_theme_index = i
						apply_theme(theme)
						save_theme(current_theme_index)
						return
					end
				end
				vim.notify("Theme not found: " .. theme_name, vim.log.levels.WARN)
			end

			-- Function to list all available themes
			function ListThemes()
				print("Available themes:")
				for i, theme in ipairs(themes) do
					local marker = (i == current_theme_index) and "* " or "  "
					print(marker .. i .. ". " .. theme.name)
				end
			end

			-- Load saved theme or use default
			current_theme_index = load_saved_theme()
			apply_theme(themes[current_theme_index])

			-- Keybindings
			vim.keymap.set("n", "<M-0>", ToggleTheme, { desc = "Toggle to next theme" })
			vim.keymap.set("n", "<M-9>", ToggleThemePrev, { desc = "Toggle to previous theme" })

			-- Create user commands
			vim.api.nvim_create_user_command("ThemeNext", ToggleTheme, { desc = "Switch to next theme" })
			vim.api.nvim_create_user_command("ThemePrev", ToggleThemePrev, { desc = "Switch to previous theme" })
			vim.api.nvim_create_user_command("ThemeList", ListThemes, { desc = "List all available themes" })
		end,
	},
}
