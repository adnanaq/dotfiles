-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Vertical scroll and center
keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Find and center
keymap.set("n", "n", "nzzzv", { desc = "Find next and center" }) -- find next and center cursor
keymap.set("n", "N", "Nzzzv", { desc = "Find previous and center" }) -- find previous and center cursor

-- Resize with arrows
keymap.set("n", "<Up>", ":resize -2<CR>", { desc = "Resize window height top" }) -- Resize window height top
keymap.set("n", "<Down>", ":resize +2<CR>", { desc = "Resize window height bottom" }) -- Resize window height bottom
keymap.set("n", "<Left>", ":vertical resize -2<CR>", { desc = "Resize window width to left" }) -- Resize window width to left
keymap.set("n", "<Right>", ":vertical resize +2<CR>", { desc = "Resize window widthto right" }) -- Resize window widthto right

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>sm", function()
	local is_maximized = vim.t.is_maximized
	if is_maximized then
		vim.cmd("wincmd =")
		vim.t.is_maximized = false
	else
		vim.cmd("wincmd _")
		vim.cmd("wincmd |")
		vim.t.is_maximized = true
	end
end, { desc = "Maximize/minimize a split" })

-- Navigate between splits
-- keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
-- keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
-- keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
-- keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Buffers
keymap.set("n", "<leader>bx", ":bdelete!<CR>", { desc = "Close current buffer" }) -- close current buffer
keymap.set("n", "<leader>bb", "<cmd> enew <CR>", { desc = "Open new buffer" }) -- open new buffer

keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Go to next buffer" }) --  go to next buffer
keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to previous buffer" }) --  go to previous buffer

-- Toggle line wrapping
keymap.set({ "n", "v" }, "<leader>lw", "<cmd>set wrap!<CR>", { desc = "Wrap line" }) --  Wrap line

-- Stay in indent mode
keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection" }) -- Indent left and keep selection
keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection" }) -- Indent right and keep selection

-- Keep last yanked when pasting
keymap.set("v", "p", '"_dP', { desc = "Keep last yanked when pasting" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "delete single character without copying into register" })

-- Oil file explorer
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" }) -- open file explorer
keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open Oil at CWD" }) -- open Oil in float

-- DAP
keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
keymap.set("n", "<leader>dB", function()
	vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
		if input then require("dap").set_breakpoint(input) end
	end)
end, { desc = "Set breakpoint with condition" })
keymap.set("n", "<leader>dA", function() require("dap").clear_breakpoints() end, { desc = "Clear all breakpoints" })
keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
keymap.set("n", "<leader>dC", function() require("dap").run_to_cursor() end, { desc = "Run to cursor" })
keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step into" })
keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step over" })
keymap.set("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step out" })
keymap.set("n", "<leader>dp", function() require("dap").step_back() end, { desc = "Step back" })
keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run last" })
keymap.set("n", "<leader>dt", function() require("dap").repl.toggle() end, { desc = "Toggle REPL" })
keymap.set("n", "<leader>dR", function() require("dap").restart() end, { desc = "Restart DAP" })
keymap.set("n", "<leader>dT", function() require("dap").terminate() end, { desc = "Terminate" })
keymap.set("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Debug Widgets" })
keymap.set("n", "<leader>dP", function() require("dap").pause() end, { desc = "Debug Pause" })

-- DAP UI
keymap.set("n", "<leader>d[", function() require("dapui").open() end, { desc = "Open DAP UI" })
keymap.set("n", "<leader>d]", function() require("dapui").close() end, { desc = "Close DAP UI" })

keymap.set("n", "<space>?", function()
	require("dapui").eval(nil, { enter = true })
end, { desc = "Eval under cursor" }) -- eval under cursor

-- Java DAP
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local jdtls = require("jdtls")

		keymap.set("n", "<leader>Jo", jdtls.organize_imports, { desc = "Organize imports", buffer = true })
		keymap.set("n", "<leader>Jv", jdtls.extract_variable, { desc = "Extract Variable", buffer = true })
		keymap.set("v", "<leader>Jv", function()
			jdtls.extract_variable(true)
		end, { desc = "Extract Variable", buffer = true })
		keymap.set("n", "<leader>Jc", jdtls.extract_constant, { desc = "Extract Constant", buffer = true })
		keymap.set("v", "<leader>Jc", function()
			jdtls.extract_constant(true)
		end, { desc = "Extract Constant", buffer = true })
		keymap.set("n", "<leader>Jm", jdtls.test_nearest_method, { desc = "Test Method", buffer = true })
		keymap.set("v", "<leader>Jm", function()
			jdtls.test_nearest_method(true)
		end, { desc = "Test Method", buffer = true })
		keymap.set("n", "<leader>JC", jdtls.test_class, { desc = "Test Class", buffer = true })
		keymap.set("n", "<leader>Ju", "<Cmd>JdtUpdateConfig<CR>", { desc = "Update Config", buffer = true })
	end,
})

-- Auto Session
keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- Trouble
keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" })
keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Open trouble document diagnostics" })
keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Open trouble quickfix list" })
keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })

-- Diagnostics
keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Go to previous diagnostic" }) -- Go to previous diagnostic
keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Go to next diagnostic" }) -- Go to next diagnostic
keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { silent = true, desc = "Show line diagnostics" }) -- Show line diagnostics

-- Neovim Lua config
vim.g.netrw_browsex_viewer = "xdg-open"
