local ok, tokyonight = pcall(require, "tokyonight")
if not ok then
  return
end

tokyonight.setup({
  -- style = "night",
  -- transparent = true,
  day_brightness = 1,
  on_colors = function(colors)
    colors.bg = "#121212"
    colors.bg_sidebar = "#121212"
  end
})

vim.cmd.colorscheme { "tokyonight-night" }
