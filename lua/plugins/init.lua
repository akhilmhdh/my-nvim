return {
	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	-- Detect tabstop and shiftwidth automatically
	-- "tpope/vim-sleuth",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim",               opts = {} },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

}
