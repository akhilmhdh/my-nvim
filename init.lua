require("config.lazy")
vim.cmd.colorscheme("catppuccin-mocha")
vim.opt.termguicolors = true
vim.wo.relativenumber = true
vim.opt.tabstop = 2
vim.g.netrw_banner = 0
vim.api.nvim_set_hl(0, "LineNr", { fg = "#BBBBBB" })
vim.opt.clipboard = "unnamedplus"
