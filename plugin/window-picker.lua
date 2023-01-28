local ok, picker = pcall(require, "window-picker")
if not ok then
	return
end

local colors = require("tokyonight.colors").setup()

picker.setup {
	filter_rules = {
		-- filter using buffer options
		bo = {
			-- if the file type is one of following, the window will be ignored
			filetype = { "notify" },

			-- if the buffer type is one of following, the window will be ignored
			buftype = {},
		},
	},

	fg_color = "#f2f2f2",
	bg_color = "#121212",

	-- if you have include_current_win == true, then current_win_hl_color will
	-- be highlighted using this background color
	current_win_hl_color = colors.blue0,

	-- all the windows except the curren window will be highlighted using this color
	other_win_hl_color = "#121212",
}
