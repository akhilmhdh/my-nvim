local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  return false
end

local function prettier_condition(utils)
  -- See https://prettier.io/docs/en/configuration.html
  local files = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettier.config.js',
    '.prettier.config.cjs',
    '.prettierrc.toml',
  }

  return utils.has_file(files) or utils.root_has_file(files)
end

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.prettierd.with({
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
    }),
    null_ls.builtins.formatting.eslint_d.with({
    }),
  },
})
