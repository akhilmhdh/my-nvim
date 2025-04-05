return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
			options = {
				offsets = { { filetype = "NvimTree", text = "File Explorer" } },
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				show_tab_indicators = true,
				color_icons = true,
				hover = {
					enabled = false, -- requires nvim 0.8+
					delay = 200,
					reveal = { "close" },
				},
				sort_by = "id",
				numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
				indicator = {
					icon = "› ", -- this should be omitted if indicator style is not 'icon'
					style = "icon", -- can also be 'underline'|'none',
				},
				name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
					-- remove extension from markdown files for example
					if buf.name:match("%.md") then
						return vim.fn.fnamemodify(buf.name, ":t:r")
					end
				end,
				max_name_length = 18,
				max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
				truncate_names = true, -- whether or not tab names should be truncated
				tab_size = 18,
				buffer_close_icon = "󰅖",
				modified_icon = "",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
			},
		})

		vim.cmd([[
function _DeleteHiddenBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
]])

		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "next buffer" })
		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "prev buffer" })
		vim.keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", { desc = "close buffers on right" })
		vim.keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", { desc = "close buffers on left" })
		vim.keymap.set("n", "<leader>bj", ":BufferLinePick<CR>", { desc = "pick a buffer" })
		vim.keymap.set("n", "<leader>bk", ":BufferLineTogglePin<CR>", { desc = "toggle a buffer pin" })
		vim.keymap.set("n", "<leader>bq", ":call _DeleteHiddenBuffers()<CR>", { desc = "close all invisible buffers" })
	end,
}
