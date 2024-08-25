return {
	"RRethy/vim-illuminate",
	config = function()
		local illuminate = require("illuminate")
		illuminate.configure({
			delay = 120,
			filetypes_denylist = {
				"dirvish",
				"fugitive",
				"alpha",
				"NvimTree",
				"lazy",
				"neogitstatus",
				"Trouble",
				"lir",
				"Outline",
				"spectre_panel",
				"toggleterm",
				"DressingSelect",
				"TelescopePrompt",
			},
			under_cursor = true
		})
		vim.keymap.set('n', ']]', illuminate.goto_next_reference, { desc = 'Go to next ref' })
		vim.keymap.set('n', '[[', illuminate.goto_prev_reference, { desc = 'Go to prev ref' })
	end
}
