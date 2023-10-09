return {
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
				cmd = { "Mason", "MasonUpdate", "MasonInstall" },
				opts = {
					ui = {
						border = "rounded",
						width = 0.6,
						height = 0.6,
						icons = {
							package_installed = "",
							package_pending = "",
							package_uninstalled = "",
						},
					},
				},
			},
			"williamboman/mason-lspconfig.nvim",
			"rmagatti/goto-preview",
			"hrsh7th/cmp-nvim-lsp",
			"folke/neodev.nvim",
		},
		config = function()
			require("neodev").setup()
			require("goto-preview").setup({})
			local lspconfig = require("lspconfig")

			-- add diagnostic icons
			local icons = { Error = " ", Warn = " ", Hint = "󰌶", Info = " " }
			for name, icon in pairs(icons) do
				vim.fn.sign_define("DiagnosticSign" .. name, { text = icon, texthl = "DiagnosticSign" .. name })
			end

			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local function on_attach(_, bufnr)
				local opts = { buffer = bufnr, noremap = true }
				local map = function(m, lhs, rhs, desc)
					opts.desc = desc
					vim.keymap.set(m, lhs, rhs, opts)
				end

				map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", "Show lsp hover")
				map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition")
				map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto declaration")
				map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto implementation")
				map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Goto type definition")
				map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "List references")
				map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Open signature help")
				map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
				map({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format buffer (async)")
				map({ "n", "v" }, "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action")
				map("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", "Code action")

				map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Open diagnostic float")
				map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic")
				map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic")

				map("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>",
					"Goto preview definition")
				map("n", "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>",
					"Goto preview type definition")
				map("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>",
					"Goto preview implementation")
				map("n", "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<cr>",
					"Goto preview declaration")
				map("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<cr>", "Goto preview close windows")
				map("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<cr>",
					"Goto preview references")
			end

			local configs = {
				["cssls"] = {},
				["html"] = {},
				["jsonls"] = {},
				["marksman"] = {},
				["pyright"] = {},
				["rust_analyzer"] = {},
				["tsserver"] = {},
				["lua_ls"] = {
					settings = {
						Lua = {
							completion = { keywordSnippet = "Both", callSnippet = "Replace" },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				}
			}

			local default_handler = function(server)
				local config = configs[server]
				config.on_attach = on_attach
				config.capabilities = capabilities
				lspconfig[server].setup(config)
			end


			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(configs),
				handlers = { default_handler }
			})
		end,
	}
}
