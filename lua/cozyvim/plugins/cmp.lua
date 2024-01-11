return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			local has_words_before = function()
				unpack = unpack or table.unpack
				local l, c = unpack(vim.api.nvim_win_get_cursor(0))
				return c ~= 0 and vim.api.nvim_buf_get_lines(0, l - 1, l, true)[1]:sub(c, c):match("%s") == nil
			end

			require("luasnip").setup({
				history = false,
				delete_check_events = "TextChanged",
				updateevents = "TextChanged,TextChangedI",
			})

			require("luasnip.loaders.from_vscode").lazy_load()

			local max_width = 40
			local base_format = lspkind.cmp_format({
				mode = "symbol_text",
				symbol_map = { copilot = "" },
				ellipsis_char = "...",
				max_width = max_width,
			})

			---@diagnostic disable: missing-fields
			cmp.setup({
				window = {
					documentation = cmp.config.window.bordered({
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
					completion = cmp.config.window.bordered({
						winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					}),
				},
				sources = {
					{ name = "path",     group_index = 1 },
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "copilot",  group_index = 1 },
					{ name = "buffer",   group_index = 2 },
					{ name = "luasnip",  group_index = 3, keyword_length = 3 },
				},
				formatting = {
					format = function(entry, vim_item)
						vim_item = base_format(entry, vim_item)

						if vim.fn.strchars(vim_item.menu) > max_width then
							vim_item.menu = vim.fn.strcharpart(vim_item.menu, 0, max_width) .. "..."
						end

						return vim_item
					end
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-e>"] = cmp.mapping.abort(),
					["<cr>"] = cmp.mapping(function(fallback)
						local entry = cmp.get_selected_entry()
						if entry then
							if entry.source.name == "copilot" then
								cmp.confirm({
									behavior = cmp.ConfirmBehavior.Replace,
									select = false,
								})
							else
								cmp.confirm({ select = false })
							end
						else
							fallback()
						end
					end),
					["<C-Space>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() and has_words_before() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
			})

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
	},
}
