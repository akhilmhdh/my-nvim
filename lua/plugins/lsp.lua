return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("fidget").setup()
			require("mason").setup()
			require("mason-lspconfig").setup()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(e)
					local nmap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end

						vim.keymap.set("n", keys, func, { buffer = e.buf, desc = desc })
					end

					nmap("<leader>ra", vim.lsp.buf.rename, "[R]e[n]ame")
					nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
					nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
					nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
					nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					nmap(
						"<leader>sws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[S]earch [W]orkspace [S]ymbols"
					)

					-- See `:help K` for why this keymap
					nmap("K", vim.lsp.buf.hover, "Hover Documentation")
					nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Documentation")

					-- Lesser used LSP functionality
					nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
					-- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
					-- nmap('<leader>wl', function()
					--  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, '[W]orkspace [L]ist Folders')

					-- Create a command `:Format` local to the LSP buffer
					vim.api.nvim_buf_create_user_command(e.buf, "Format", function(_)
						vim.lsp.buf.format({ timeout_ms = 5000 })
					end, { desc = "Format current buffer with LSP" })
					-- nmap('<C-f>', ":Format<CR>", "[F]ormat")
				end,
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"tailwindcss",
					"terraformls",
					"gopls",
					"html",
					"pyright",
					"ruff",
					"ts_ls",
					"ruby_lsp",
				},
				handlers = {
					function(server_name)
						local cmp_lsp = require("cmp_nvim_lsp")
						local capabilites = vim.tbl_deep_extend(
							"force",
							{},
							vim.lsp.protocol.make_client_capabilities(),
							cmp_lsp.default_capabilities()
						)

						require("lspconfig")[server_name].setup({
							capabilites = capabilites,
						})
					end,
					["ts_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.ts_ls.setup({
							root_dir = lspconfig.util.root_pattern("package.json"),
							single_file_support = false,
						})
					end,
					["rust_analyzer"] = function() end,
					["tailwindcss"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.tailwindcss.setup({
							flags = {
								debounce_text_changes = 1000,
							},
						})
					end,
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
								},
							},
						})
					end,
				},
			})

			--- nvim cmp config
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})

			vim.diagnostic.config({
				update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
	{
		-- RUST LSP
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				-- Plugin configuration
				tools = {
					autoSetHints = true,
					inlay_hints = {
						show_parameter_hints = true,
						parameter_hints_prefix = "in: ", -- "<- "
						other_hints_prefix = "out: ", -- "=> "
					},
				},
				-- LSP configuration
				--
				-- REFERENCE:
				-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
				-- https://rust-analyzer.github.io/manual.html#configuration
				-- https://rust-analyzer.github.io/manual.html#features
				--
				-- NOTE: The configuration format is `rust-analyzer.<section>.<property>`.
				--       <section> should be an object.
				--       <property> should be a primitive.
				server = {
					settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							assist = {
								importEnforceGranularity = true,
								importPrefix = "create",
							},
							cargo = { allFeatures = true },
							checkOnSave = {
								-- default: `cargo check`
								command = "clippy",
								allFeatures = true,
							},
							inlayHints = {
								lifetimeElisionHints = {
									enable = true,
									useParameterNames = true,
								},
							},
						},
					},
				},
			}
		end,
	},
}
