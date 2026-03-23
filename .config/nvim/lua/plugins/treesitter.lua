return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- treesitter doesn't support lazy loading
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
		},
	},
	config = function()
		-- Install language parsers on startup (new main branch API)
		local ts = require("nvim-treesitter")

		ts.install({
			"bash",
			"c",
			"css",
			"dockerfile",
			"hcl",
			"helm",
			"html",
			"gitignore",
			"go",
			"graphql",
			"java",
			"javascript",
			"json",
			"kotlin",
			"lua",
			"markdown",
			"markdown_inline",
			"prisma",
			"proto",
			"python",
			"query",
			"ruby",
			"scss",
			"terraform",
			"tsx",
			"typescript",
			"yaml",
			"vim",
			"vimdoc",
		}, { summary = false })

		-- Enable treesitter highlighting and indentation for all filetypes
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(event)
				local buf = event.buf
				local ft = event.match

				-- Enable syntax highlighting
				pcall(vim.treesitter.start, buf, ft)

				-- Enable indentation (experimental)
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		-- Note: Incremental selection was removed in main branch
		-- Use textobjects for selection instead

		-- Configure textobjects (main branch API)
		-- IMPORTANT: setup() only accepts options, NOT keymaps!
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		})

		-- Textobject Select keymaps (must be set manually in main branch!)
		local ts_select = require("nvim-treesitter-textobjects.select")

		-- Assignment textobjects
		vim.keymap.set({ "x", "o" }, "a=", function()
			ts_select.select_textobject("@assignment.outer", "textobjects")
		end, { desc = "Outer Assignment" })
		vim.keymap.set({ "x", "o" }, "i=", function()
			ts_select.select_textobject("@assignment.inner", "textobjects")
		end, { desc = "Inner Assignment" })

		-- Property textobjects
		vim.keymap.set({ "x", "o" }, "a:", function()
			ts_select.select_textobject("@property.outer", "textobjects")
		end, { desc = "Outer Object Property" })
		vim.keymap.set({ "x", "o" }, "i:", function()
			ts_select.select_textobject("@property.inner", "textobjects")
		end, { desc = "Inner Object Property" })

		-- Parameter/Argument textobjects
		vim.keymap.set({ "x", "o" }, "aa", function()
			ts_select.select_textobject("@parameter.outer", "textobjects")
		end, { desc = "Outer Parameter/Argument" })
		vim.keymap.set({ "x", "o" }, "ia", function()
			ts_select.select_textobject("@parameter.inner", "textobjects")
		end, { desc = "Inner Parameter/Argument" })

		-- Conditional textobjects
		vim.keymap.set({ "x", "o" }, "ai", function()
			ts_select.select_textobject("@conditional.outer", "textobjects")
		end, { desc = "Outer Conditional" })
		vim.keymap.set({ "x", "o" }, "ii", function()
			ts_select.select_textobject("@conditional.inner", "textobjects")
		end, { desc = "Inner Conditional" })

		-- Loop textobjects
		vim.keymap.set({ "x", "o" }, "al", function()
			ts_select.select_textobject("@loop.outer", "textobjects")
		end, { desc = "Outer Loop" })
		vim.keymap.set({ "x", "o" }, "il", function()
			ts_select.select_textobject("@loop.inner", "textobjects")
		end, { desc = "Inner Loop" })

		-- Function textobjects
		vim.keymap.set({ "x", "o" }, "af", function()
			ts_select.select_textobject("@function.outer", "textobjects")
		end, { desc = "Outer Function" })
		vim.keymap.set({ "x", "o" }, "if", function()
			ts_select.select_textobject("@function.inner", "textobjects")
		end, { desc = "Inner Function" })

		-- Call/Method textobjects
		vim.keymap.set({ "x", "o" }, "am", function()
			ts_select.select_textobject("@call.outer", "textobjects")
		end, { desc = "Outer Method Call" })
		vim.keymap.set({ "x", "o" }, "im", function()
			ts_select.select_textobject("@call.inner", "textobjects")
		end, { desc = "Inner Method Call" })

		-- Class textobjects
		vim.keymap.set({ "x", "o" }, "ac", function()
			ts_select.select_textobject("@class.outer", "textobjects")
		end, { desc = "Outer Class" })
		vim.keymap.set({ "x", "o" }, "ic", function()
			ts_select.select_textobject("@class.inner", "textobjects")
		end, { desc = "Inner Class" })

		-- Comment textobjects
		vim.keymap.set({ "x", "o" }, "at", function()
			ts_select.select_textobject("@comment.outer", "textobjects")
		end, { desc = "Outer Comment" })

		-- Swap keymaps (manually set as per README)
		local ts_swap = require("nvim-treesitter-textobjects.swap")
		vim.keymap.set("n", "<leader>na", function()
			ts_swap.swap_next("@parameter.inner")
		end, { desc = "Swap Parameter/Argument Next" })
		vim.keymap.set("n", "<leader>n:", function()
			ts_swap.swap_next("@property.outer")
		end, { desc = "Swap Property Next" })
		vim.keymap.set("n", "<leader>nm", function()
			ts_swap.swap_next("@function.outer")
		end, { desc = "Swap Function Next" })

		vim.keymap.set("n", "<leader>pa", function()
			ts_swap.swap_previous("@parameter.inner")
		end, { desc = "Swap Parameter/Argument Previous" })
		vim.keymap.set("n", "<leader>p:", function()
			ts_swap.swap_previous("@property.outer")
		end, { desc = "Swap Property Previous" })
		vim.keymap.set("n", "<leader>pm", function()
			ts_swap.swap_previous("@function.outer")
		end, { desc = "Swap Function Previous" })

		-- Move keymaps (manually set as per README)
		local ts_move = require("nvim-treesitter-textobjects.move")

		-- Next start
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			ts_move.goto_next_start("@call.outer", "textobjects")
		end, { desc = "Next function call start" })
		vim.keymap.set({ "n", "x", "o" }, "]m", function()
			ts_move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next method/function def start" })
		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			ts_move.goto_next_start("@class.outer", "textobjects")
		end, { desc = "Next class start" })
		vim.keymap.set({ "n", "x", "o" }, "]i", function()
			ts_move.goto_next_start("@conditional.outer", "textobjects")
		end, { desc = "Next conditional start" })
		vim.keymap.set({ "n", "x", "o" }, "]l", function()
			ts_move.goto_next_start("@loop.outer", "textobjects")
		end, { desc = "Next loop start" })

		-- Next end
		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			ts_move.goto_next_end("@call.outer", "textobjects")
		end, { desc = "Next function call end" })
		vim.keymap.set({ "n", "x", "o" }, "]M", function()
			ts_move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "Next method/function def end" })
		vim.keymap.set({ "n", "x", "o" }, "]C", function()
			ts_move.goto_next_end("@class.outer", "textobjects")
		end, { desc = "Next class end" })
		vim.keymap.set({ "n", "x", "o" }, "]I", function()
			ts_move.goto_next_end("@conditional.outer", "textobjects")
		end, { desc = "Next conditional end" })
		vim.keymap.set({ "n", "x", "o" }, "]L", function()
			ts_move.goto_next_end("@loop.outer", "textobjects")
		end, { desc = "Next loop end" })

		-- Previous start
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			ts_move.goto_previous_start("@call.outer", "textobjects")
		end, { desc = "Prev function call start" })
		vim.keymap.set({ "n", "x", "o" }, "[m", function()
			ts_move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Prev method/function def start" })
		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			ts_move.goto_previous_start("@class.outer", "textobjects")
		end, { desc = "Prev class start" })
		vim.keymap.set({ "n", "x", "o" }, "[i", function()
			ts_move.goto_previous_start("@conditional.outer", "textobjects")
		end, { desc = "Prev conditional start" })
		vim.keymap.set({ "n", "x", "o" }, "[l", function()
			ts_move.goto_previous_start("@loop.outer", "textobjects")
		end, { desc = "Prev loop start" })

		-- Previous end
		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			ts_move.goto_previous_end("@call.outer", "textobjects")
		end, { desc = "Prev function call end" })
		vim.keymap.set({ "n", "x", "o" }, "[M", function()
			ts_move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "Prev method/function def end" })
		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			ts_move.goto_previous_end("@class.outer", "textobjects")
		end, { desc = "Prev class end" })
		vim.keymap.set({ "n", "x", "o" }, "[I", function()
			ts_move.goto_previous_end("@conditional.outer", "textobjects")
		end, { desc = "Prev conditional end" })
		vim.keymap.set({ "n", "x", "o" }, "[L", function()
			ts_move.goto_previous_end("@loop.outer", "textobjects")
		end, { desc = "Prev loop end" })


		-- Configure repeatable move
		local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
	end,
}
