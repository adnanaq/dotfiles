-- Set leader key
vim.g.mapleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Vertical scroll and center
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" }) -- scroll down and center cursor
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" }) -- scroll up and center cursor

-- Find and center
keymap.set("n", "n", "nzzzv", { desc = "Find next and center" }) -- find next and center cursor
keymap.set("n", "N", "Nzzzv", { desc = "Find previous and center" }) -- find previous and center cursor

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Resize with arrows
keymap.set('n', '<Up>', ':resize -2<CR>', { desc = "Resize window height top" }) -- Resize window height top
keymap.set('n', '<Down>', ':resize +2<CR>', { desc = "Resize window height bottom" }) -- Resize window height bottom
keymap.set('n', '<Left>', ':vertical resize -2<CR>', { desc = "Resize window width to left" }) -- Resize window width to left
keymap.set('n', '<Right>', ':vertical resize +2<CR>', { desc = "Resize window widthto right" }) -- Resize window widthto right

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Buffers
keymap.set('n', '<Tab>', ':bnext<CR>', { desc = "Go to next buffer" }) --  go to next buffer
keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = "Go to previous buffer" }) --  go to previous buffer
keymap.set('n', '<leader>bx', ':bdelete!<CR>', { desc = "Close current buffer" }) -- close current buffer
keymap.set('n', '<leader>bb', '<cmd> enew <CR>', { desc = "Open new buffer" }) -- open new buffer

-- Tabs
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", ":tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Toggle line wrapping
keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { desc = "Wrap line" }) --  Wrap line

-- Stay in indent mode
keymap.set('v', '<', '<gv', { desc = "Indent left and keep selection" }) -- Indent left and keep selection
keymap.set('v', '>', '>gv', { desc = "Indent right and keep selection" }) -- Indent right and keep selection