local deps_ok, kanagawa, tint = pcall(function()
	return require "kanagawa"
end)
if not deps_ok then
	return
end

--  KANAGAWA_COLORS = require("kanagawa.colors").setup()
--
--  local colors = {
-- 	bg = "#000000",
-- 	crystalBlue = "#89a9e8",
--
-- }
--
-- require('kanagawa').setup({
--  	theme = "dark",
--  	colors = colors,
--  })
--
--  vim.cmd.colorscheme { "kanagawa" }
