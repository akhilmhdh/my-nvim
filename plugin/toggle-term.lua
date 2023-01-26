local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
	return
end

toggleterm.setup {
	insert_mappings = false,
	env = {
		MANPAGER = "less -X",
	},
	terminal_mappings = false,
	start_in_insert = true,
	persist_mode = true,
	open_mapping = [[<leader>t]],
	direction = 'horizontal',
	highlights = {
		CursorLineSign = { link = "DarkenedPanel" },
		Normal = { guibg = "#121212" },
	},
	shell = vim.o.shell
}
