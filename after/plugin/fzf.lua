vim.api.nvim_set_keymap('n', '<c-p>',
	"<cmd>lua require('fzf-lua').files()<CR>",
	{ noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader><c-p>',
	"<cmd>lua require('fzf-lua').buffers()<CR>",
	{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fg',
	"<cmd>lua require('fzf-lua').live_grep()<CR>",
	{ noremap = true, silent = true })
