return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		term_colors = true,
		transparent_background = false,
		color_overrides = {
			mocha = {
				base = "#000000",
				mantle = "#000000",
				crust = "#000000",
				mauve = "#c392fc",
				blue = "#70a5eb",
				maroon = "#e36277"
			},
		},
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			which_key = true,
			fidget = true,
			illuminate = {
				enabled = true,
				lsp = false
			},
		},
	},

}
