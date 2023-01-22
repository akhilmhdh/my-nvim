local keymap = vim.keymap.set

-- Open horizontal terminal
keymap("n", "<leader>th", ":below 18 sp<CR>:term<CR>i", { silent = true })
keymap("t", "<leader>tc", "exit<CR>", { silent = true })
keymap('t', '<C-c>', [[<C-\><C-n>]], { silent = true })

keymap("n", "<leader>s", ":w<CR>")

-- Move selected lines in visual mode up or down, awesome!
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Paste from clipboard
keymap("x", "cv", "\"+p")
keymap("n", "cv", "\"+p")

-- yank to clipboard
keymap("n", "cp", "\"+y")
keymap("v", "cp", "\"+y")
keymap("n", "cp", "\"+Y")

-- exit from insert mode
keymap("i", "<C-c>", "<Esc>")
