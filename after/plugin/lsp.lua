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
  ensure_installed = { "lua_ls", "rust_analyzer", "cssls", "cssmodules_ls",
    "eslint", "gopls", "html", "jsonls", "tsserver", "tailwindcss", "taplo", "terraformls", "yamlls",
  },
}

mason_lspconfig.setup_handlers {}

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '[e', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] })
end, opts)
vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] })
end, opts)
vim.keymap.set('n', '[w', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] })
end, opts)
vim.keymap.set('n', ']w', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] })
end, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', "<cmd>lua require('fzf-lua').lsp_references()<CR>", bufopts)
  vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>vws", "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>", opts)
  vim.keymap.set("n", "<leader>vd", "<cmd>lua require('fzf-lua').diagnostics_document()<CR>", opts)
  vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
end

-- LUA LSP
lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
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
lspconfig.terraformls.setup { on_attach = on_attach }
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
  on_attach = on_attach,
}))

lspconfig.cssls.setup(coq.lsp_ensure_capabilities({
  capabilities = capabilities,
  on_attach = on_attach,
}))

lspconfig.cssmodules_ls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach
}))

-- GOLANG LSP
lspconfig.gopls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
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
  on_attach = function(client, buffer)
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, buffer)
  end,
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
      auto = true
    }
  },
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = on_attach,
}))

-- JSON LSP
lspconfig.jsonls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })

-- YAML LSP
lspconfig.yamlls.setup(coq.lsp_ensure_capabilities({
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
    },
  },
  on_attach = on_attach,
}))

-- TOML
lspconfig.taplo.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach
}))

-- TAILWIND LSP
lspconfig.tailwindcss.setup(coq.lsp_ensure_capabilities({ on_attach = on_attach }))

--
