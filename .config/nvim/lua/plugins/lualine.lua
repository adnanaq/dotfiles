return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lazy_status = require("lazy.status")

		local diagnostic = {
			symbols = {
				error = " ",
				warn = " ",
				info = " ",
				hint = " ",
			},
		}

		-- Map vim modes to lualine highlight groups (populated by theme = "auto")
		local mode_hl = {
			n  = "lualine_a_normal",
			i  = "lualine_a_insert",
			v  = "lualine_a_visual",
			V  = "lualine_a_visual",
			["\22"] = "lualine_a_visual", -- visual block
			c  = "lualine_a_command",
			R  = "lualine_a_replace",
			t  = "lualine_a_terminal",
		}

		local function mode_color()
			local hl_name = mode_hl[vim.fn.mode()] or "lualine_a_normal"
			local hl = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
			local bg = hl.bg and string.format("#%06x", hl.bg)
			return { fg = bg or "NONE", bg = "NONE" }
		end

		require("lualine").setup({
			options = {
				globalstatus = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						function() return "⬤" end,
						color = mode_color,
						padding = { left = 1, right = 0 },
					},
				},
				lualine_b = {
					{
						"branch",
						fmt = function(s) return #s > 20 and s:sub(1, 20) .. "…" or s end,
					},
					"diff",
				},
				lualine_c = {
					{
						"filename",
						color = mode_color,
						file_status = true,
						symbols = {
							modified = "[●]",
							readonly = "[]",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
					"lsp_status",
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "diagnostics", symbols = diagnostic.symbols },
					"filetype",
				},
				lualine_y = { "fileformat", "encoding" },
				lualine_z = { "location", "progress" },
			},
		})
	end,
}
