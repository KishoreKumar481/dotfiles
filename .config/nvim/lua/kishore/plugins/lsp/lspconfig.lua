return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		---------------------------------------------------------------------
		-- Default capabilities for all servers (completion support)
		---------------------------------------------------------------------
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		vim.lsp.config.capabilities = cmp_nvim_lsp.default_capabilities()

		---------------------------------------------------------------------
		-- LSP Server configurations (NEW API — everything in one place)
		---------------------------------------------------------------------
		local servers = {

			-------------------------------------------------------------------
			-- Lua
			-------------------------------------------------------------------
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},

			-------------------------------------------------------------------
			-- Svelte
			-------------------------------------------------------------------
			svelte = {
				on_attach = function(client)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			},

			-------------------------------------------------------------------
			-- GraphQL
			-------------------------------------------------------------------
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},

			-------------------------------------------------------------------
			-- Emmet
			-------------------------------------------------------------------
			emmet_ls = {
				filetypes = {
					"html",
					"css",
					"sass",
					"scss",
					"less",
					"typescriptreact",
					"javascriptreact",
					"svelte",
				},
			},

			-------------------------------------------------------------------
			-- VTSLS (Modern TS/JS LSP)
			-------------------------------------------------------------------
			vtsls = {
				settings = {
					vtsls = {
						autoUseWorkspaceTsdk = true,
					},
				},
			},

			-------------------------------------------------------------------
			-- No-config-needed servers
			-------------------------------------------------------------------
			html = {},
			cssls = {},
			tailwindcss = {
				settings = {
					tailwindCSS = {
						includeLanguages = {
							javascript = "javascriptreact",
							javascriptreact = "javascriptreact",
							typescript = "typescriptreact",
							typescriptreact = "typescriptreact",
						},

						experimental = {
							classRegex = {
								{ 'className="([^"]*)"', '([^"]+)' },
								{ 'class="([^"]*)"', '([^"]+)' },
							},
						},

						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidConfigPath = "error",
							invalidScreen = "error",
							invalidTailwindDirective = "error",
							invalidVariant = "error",
							recommendedVariantOrder = "warning",
						},

						validate = true,
					},
				},

				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
					"vue",
				},
			},
			prismals = {},
			pyright = {},
		}

		---------------------------------------------------------------------
		-- APPLY configs using new vim.lsp.config() API
		---------------------------------------------------------------------
		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
		end
		---------------------------------------------------------------------
		-- Diagnostic symbols
		---------------------------------------------------------------------

		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				prefix = "●",
				source = "if_many",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
		---------------------------------------------------------------------
		-- Keymaps on LspAttach
		---------------------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local keymap = vim.keymap
				local opts = { buffer = ev.buf, silent = true }

				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap.set("n", "<leader>rn", function()
					vim.lsp.buf.rename(nil, {
						prepare = false,
					})
				end, opts)

				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				keymap.set("n", "K", vim.lsp.buf.hover, opts)
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})
	end,
}
