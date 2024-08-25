return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup {
			open_mapping = [[<C-t>]],
			direction = "float",
			float_opts = {
				border = "curved",
				-- width = <value>,
				-- height = <value>,
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			}
		}

		local Terminal = require('toggleterm.terminal').Terminal
		local lazygit  = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "none",
				width = 100000,
				height = 100000,
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
					{ noremap = true, silent = true })
			end,
			-- function to run on closing the terminal
			on_close = function()
				vim.cmd("startinsert!")
			end,
		})

		function _Lazygit_toggle()
			lazygit:toggle()
		end

		vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _Lazygit_toggle()<CR>",
			{ noremap = true, silent = true })
	end,
}
