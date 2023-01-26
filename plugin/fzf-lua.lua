local ok, fzf = pcall(require, "fzf-lua")
if not ok then
	return
end

fzf.setup({})
