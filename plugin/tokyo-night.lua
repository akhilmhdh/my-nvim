local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
	return
end

tokyonight.setup({
	style = "night",
	on_colors = function(colors)
		colors.bg = "#000000"
		colors.bg_sidebar = "#121212"
	end
})

vim.cmd.colorscheme { "tokyonight-night" }
