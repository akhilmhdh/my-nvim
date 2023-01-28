local keymap = vim.keymap.set

-- Open horizontal terminal
-- keymap("n", "<leader>th", ":below 18 sp<CR>:term<CR>i", { silent = true })
-- keymap("t", "<leader>tc", "exit<CR>", { silent = true })
keymap('t', '<Esc>', [[<C-\><C-n>]], { silent = true })

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

keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- split
keymap("n", "<leader>vs", ":vsplit<CR>")
keymap("n", "<leader>hs", ":split<CR>")

keymap("n", "<Left>", ":vertical resize +1<CR>", { noremap = true, silent = true })
keymap("n", "<Right>", ":vertical resize -1<CR>", { noremap = true, silent = true })
keymap("n", "<Up>", ":resize -1<CR>", { noremap = true, silent = true })
keymap("n", "<Down>", ":resize +1<CR>", { noremap = true, silent = true })

-- navigation in insert mode
keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-l>", "<Right>")
keymap("n", "<M-q>", ":q<CR>")

-- duplicate selected lines or line
keymap("n", "<leader>dp", ":t.<CR>", { silent = true })
keymap("n", "<leader>dP", ":t-1<CR>", { silent = true })
keymap("v", "<leader>dp", ":'<,'>t'><CR>", { silent = true })
keymap("v", "<leader>dP", ":'<,'>t'<<CR>", { silent = true })

-- keymap("n", "J", "5j")
-- keymap("n", "K", "5k")

keymap("n", "<leader><tab>", ":tabnew<CR>", { noremap = true, silent = true })
keymap("n", "<tab>", ":tabnext<CR>", { noremap = true, silent = true })
keymap("n", "<S-tab>", ":tabprevious<CR>", { noremap = true, silent = true })
keymap("n", "<C-w>", ":tabclose<CR>", { noremap = true, silent = true })

keymap("n", "<leader>q", ":q<CR>", { silent = true })
