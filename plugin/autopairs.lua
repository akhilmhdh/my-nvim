local ok, pairs = pcall(require, "nvim-autopairs")
if not ok then
	return
end

pairs.setup({})

