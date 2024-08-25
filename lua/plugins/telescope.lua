return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',

	-- or                              , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- NOTE: If you are having trouble with this installation,
			--       refer to the README for telescope-fzf-native for more instructions.
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
	},

	config = function()
		local telescope = require("telescope")
		telescope.setup({})
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		-- See `:help telescope.builtin`
		vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles,
			{ desc = '[?] Find recently opened files' })
		vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers,
			{ desc = '[ ] Find existing buffers' })
		vim.keymap.set('n', '<leader>/', function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, { desc = '[/] Fuzzily search in current buffer' })

		vim.keymap.set('n', '<leader>sf', require('telescope.builtin').git_files,
			{ desc = 'Search [G]it [F]iles' })
		vim.keymap.set('n', '<leader>f', require('telescope.builtin').fd, { desc = '[S]earch [F]iles' })
		vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
			{ desc = '[S]earch current [W]ord' })
		vim.keymap.set('n', '<leader>st', require('telescope').extensions.live_grep_args.live_grep_args,
			{ desc = '[S]earch by [T]ext' })
		vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
			{ desc = '[S]earch [D]iagnostics' })
		vim.keymap.set('n', '<leader>sm', require('telescope.builtin').marks, { desc = '[S]earch vim [M]arks' })
	end,
}
