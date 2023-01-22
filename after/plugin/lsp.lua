local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	return
end

local ok1, coq = pcall(require, "coq")
if not ok1 then
	return
end

local ok2, lspconfig = pcall(require, "lspconfig")
if not ok2 then
	return
end



mason_lspconfig.setup {
	ensure_installed = { "sumneko_lua", "rust_analyzer", "cssls", "cssmodules_ls", "cssmodules_ls",
		"eslint", "gopls", "html", "jsonls", "tsserver", "tailwindcss", "taplo", "terraformls", "yamlls",
	},
}

mason_lspconfig.setup_handlers {}

lspconfig.sumneko_lua.setup(coq.lsp_ensure_capabilities({
	settings = {
		Lua = {
			hint = {
				enable = true,
				arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
				await = true,
				paramName = "Disable", -- "All", "Literal", "Disable"
				paramType = false,
				semicolon = "Disable", -- "All", "SameLine", "Disable"
				setType = true,
			},
			diagnostics = {
				globals = { "P", "vim", "use" },
			},
		},
	},
}))
