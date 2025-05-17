local wk = require("which-key")

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Vertical scroll and center
-- keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" }) -- scroll down and center cursor
-- keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" }) -- scroll up and center cursor

-- Find and center
keymap.set("n", "n", "nzzzv", { desc = "Find next and center" }) -- find next and center cursor
keymap.set("n", "N", "Nzzzv", { desc = "Find previous and center" }) -- find previous and center cursor

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Resize with arrows
keymap.set("n", "<Up>", ":resize -2<CR>", { desc = "Resize window height top" }) -- Resize window height top
keymap.set("n", "<Down>", ":resize +2<CR>", { desc = "Resize window height bottom" }) -- Resize window height bottom
keymap.set("n", "<Left>", ":vertical resize -2<CR>", { desc = "Resize window width to left" }) -- Resize window width to left
keymap.set("n", "<Right>", ":vertical resize +2<CR>", { desc = "Resize window widthto right" }) -- Resize window widthto right

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Navigate between splits
-- keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
-- keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
-- keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
-- keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Buffers
keymap.set("n", "<leader>bx", ":bdelete!<CR>", { desc = "Close current buffer" }) -- close current buffer
keymap.set("n", "<leader>bb", "<cmd> enew <CR>", { desc = "Open new buffer" }) -- open new buffer

-- Tabs
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", ":tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Go to next buffer" }) --  go to next buffer
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to previous buffer" }) --  go to previous buffer

-- Toggle line wrapping
keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", { desc = "Wrap line" }) --  Wrap line

-- Stay in indent mode
keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" }) -- Indent left and keep selection
keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" }) -- Indent right and keep selection

-- Keep last yanked when pasting
keymap.set("v", "p", '"_dP', { desc = "Keep last yanked when pasting" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "delete single character without copying into register" })

-- Oil file explorer
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" }) -- open file explorer
keymap.set("n", "<leader>ee", ":e .<CR>", { desc = "Open Oil at CWD" }) -- open Oil at CWD

-- DAP
keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" }) -- toggle breakpoint
keymap.set("n", "<leader>dB", function()
	vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
		if input then
			require("dap").set_breakpoint(input)
		end
	end)
end, { desc = "Set breakpoint with condition" }) -- set breakpoint with condition
keymap.set("n", "<leader>dA", function()
	require("dap").clear_breakpoints()
end, { desc = "Clear all breakpoint" }) -- clear all breakpoints
keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Continue" }) -- continue
keymap.set("n", "<leader>dC", function()
	require("dap").run_to_cursor()
end, { desc = "Run to cursor" }) -- run to cursor
keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Step into" }) -- step into
keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Step over" }) -- step over
keymap.set("n", "<leader>dO", function()
	require("dap").step_out()
end, { desc = "Step out" }) -- step out
keymap.set("n", "<leader>dp", function()
	require("dap").step_back()
end, { desc = "Step back" }) -- step back
keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "Run last" }) -- run last
keymap.set("n", "<leader>dt", function()
	require("dap").repl.toggle()
end, { desc = "Toggle REPL" }) -- toggle REPL
keymap.set("n", "<leader>dR", function()
	require("dap").restart()
end, { desc = "Restart DAP" }) -- restart DAP
keymap.set("n", "<leader>dT", function()
	require("dap").terminate()
end, { desc = "Terminate" }) -- terminate

-- DAP UI
keymap.set("n", "<leader>d[", function()
	require("dapui").open()
end, { desc = "Open" }) -- Open DAP UI
keymap.set("n", "<leader>d]", function()
	require("dapui").close()
end, { desc = "Close" }) -- Open DAP UI

keymap.set("n", "<space>?", function()
	require("dapui").eval(nil, { enter = true })
end, { desc = "Eval under cursor" }) -- eval under cursor

-- Java DAP
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local jdtls = require("jdtls")
		local opts = { buffer = 0 }

		keymap.set("n", "<leader>Jo", jdtls.organize_imports, { desc = "[J]ava [O]rganize Imports", buffer = true })
		keymap.set("n", "<leader>Jv", jdtls.extract_variable, { desc = "[J]ava Extract [V]ariable", buffer = true })
		keymap.set("v", "<leader>Jv", function()
			jdtls.extract_variable(true)
		end, { desc = "[J]ava Extract [V]ariable", buffer = true })
		keymap.set("n", "<leader>Jc", jdtls.extract_constant, { desc = "[J]ava Extract [C]onstant", buffer = true })
		keymap.set("v", "<leader>Jc", function()
			jdtls.extract_constant(true)
		end, { desc = "[J]ava Extract [C]onstant", buffer = true })
		keymap.set("n", "<leader>Jm", jdtls.test_nearest_method, { desc = "[J]ava Test [M]ethod", buffer = true })
		keymap.set("v", "<leader>Jm", function()
			jdtls.test_nearest_method(true)
		end, { desc = "[J]ava Test [M]ethod", buffer = true })
		keymap.set("n", "<leader>JC", jdtls.test_class, { desc = "[J]ava Test [C]lass", buffer = true })
		keymap.set("n", "<leader>Ju", "<Cmd>JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config", buffer = true })
	end,
})

-- Codium
keymap.set("i", "<C-g>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true })
keymap.set("i", "<C-f>", function()
	return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true })
keymap.set("i", "<C-d>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true })
keymap.set("i", "<C-s>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true })

-- Vim Maximizer
keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize a split" }) -- maximize/minimize a split

-- Auto Session
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- Trouble
wk.add({
	{ "<leader>x", group = "Trouble" },
	{ "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics", mode = "n" }, -- open trouble workspace diagnostics
	{
		"<leader>xd",
		"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
		desc = "Open trouble document diagnostics",
		mode = "n",
	}, -- open trouble document diagnostics
	{ "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Open trouble quickfix list", mode = "n" }, -- open trouble quickfix list
	{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list", mode = "n" }, -- open trouble location list
	{ "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble", mode = "n" }, -- open todos in trouble
})

-- keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" }) -- open trouble workspace diagnostics
-- keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Open trouble document diagnostics", }) -- open trouble document diagnostics
-- keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" }) -- open trouble quickfix list
-- keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" }) -- open trouble location list
-- keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" }) -- open todos in trouble
