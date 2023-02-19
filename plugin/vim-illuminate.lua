local illuminate = require("illuminate")

illuminate.configure({
	filetypes_denylist = {
		'dirvish',
		'fugitive',
		'neo-tree'
	},
})


vim.keymap.set('n', ']]', illuminate.goto_next_reference, { desc = "Move to next reference" })
vim.keymap.set('n', '[[', illuminate.goto_prev_reference, { desc = "Move to next reference" })
