local set = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- these allow for moving selection up or down
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- up and down movements and moving to search results
-- stay in the middle of screen
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- copying to system clipboard
set("n", "<leader>y", '"+y')
set("v", "<leader>y", '"+y')
set("n", "<leader>Y", '"+Y')

-- escaping terminal mode
set("t", "<Esc>", "<C-\\><C-n>")

-- resizing panes
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<c-w>+")
set("n", "<M-s>", "<c-w>-")
