vim.api.nvim_set_keymap('n', '<c-p>',
	"<cmd>lua require('fzf-lua').files()<CR>",
	{ noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>fbuf',
	"<cmd>lua require('fzf-lua').buffers()<CR>",
	{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fr',
	"<cmd>lua require('fzf-lua').oldfiles()<CR>",
	{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fg',
	"<cmd>lua require('fzf-lua').live_grep()<CR>",
	{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>flr',
	"<cmd>lua require('fzf-lua').lsp_references()<CR>",
	{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>fld',
	"<cmd>lua require('fzf-lua').lsp_definitions<CR>",
	{ noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ftdef',
	"<cmd>lua require('fzf-lua').lsp_typedefs()<CR>",
	{ noremap = true, silent = true })
