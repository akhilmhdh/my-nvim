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

local util = require("lspconfig/util")

mason_lspconfig.setup {
	ensure_installed = { "sumneko_lua", "rust_analyzer", "cssls", "cssmodules_ls",
		"eslint", "gopls", "html", "jsonls", "tsserver", "tailwindcss", "taplo", "terraformls", "yamlls",
	},
}

mason_lspconfig.setup_handlers {}

-- LUA LSP
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

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- TERRAFORM LSP
lspconfig.terraformls.setup {}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

-- HTML LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup(coq.lsp_ensure_capabilities({
	capabilities = capabilities,
}))

-- GOLANG LSP
lspconfig.gopls.setup(coq.lsp_ensure_capabilities({
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))

-- order imports
function Go_org_imports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for cid, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		end
	end
end

vim.cmd [[ autocmd BufWritePre *.go lua Go_org_imports() ]]

-- TYPESCRIPT LSP
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = 'all',
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			}
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = 'all',
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			}
		}
	}
}))

-- RUST LSP
require("rust-tools").setup(coq.lsp_ensure_capabilities({
	tools = {
		inlay_hints = {
			auto = false
		}
	},
	flags = {
		debounce_text_changes = 150,
	},
}))

-- JSON LSP
lspconfig.jsonls.setup(coq.lsp_ensure_capabilities {})

-- YAML LSP
lspconfig.yamlls.setup(coq.lsp_ensure_capabilities({
	settings = {
		yaml = {
			hover = true,
			completion = true,
			validate = true,
			schemas = require("schemastore").json.schemas(),
		},
	},
}))
