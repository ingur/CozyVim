return {
	{
		"tpope/vim-sleuth", -- smarter shiftwidth/expandtab
		event = { "BufReadPost", "BufNewFile" },
	},

	{
		"romainl/vim-cool", -- smarter search highlights
		event = "BufRead",
	},

	{
		"karb94/neoscroll.nvim", -- smooth scrolling
		keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		config = true,
	},

	{
		"ggandor/leap.nvim", -- adds fast vim motions
		lazy = false,
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},

	{
		"nacro90/numb.nvim", -- peak lines with linenumbers
		event = "BufRead",
		opts = {
			show_cursorline = false,
		},
	},

	{
		"numToStr/Comment.nvim", -- comment selections
		event = "BufReadPost",
		config = true,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	{
		"kylechui/nvim-surround", -- surround selections
		version = "*",
		event = "VeryLazy",
		config = function(_, opts)
			require("nvim-surround").setup(opts)
		end,
	},

	{
		"ggandor/leap.nvim", -- adds fast vim motions
		lazy = false,
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},

	{
		"folke/todo-comments.nvim", -- comment highlights
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		keys = {
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous todo comment",
			},
		},
		opts = {
			gui_style = {
				fg = "BOLD",
			},
			highlight = {
				keyword = "fg",
			},
			colors = {
				info = { "Purple" },
			},
		},
		config = true,
	},

	{
		"folke/trouble.nvim", -- list of diagnostics
		cmd = { "TroubleToggle", "Trouble" },
		opts = {
			use_diagnostic_signs = true,
		},
		keys = {
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").previous({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if err and not ok then
							vim.notify(err, vim.log.levels.INFO)
						end
					end
				end,
				desc = "Previous trouble/quickfix item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if err and not ok then
							vim.notify(err, vim.log.levels.INFO)
						end
					end
				end,
				desc = "Next trouble/quickfix item",
			},
		},
	},

	{
		"lewis6991/gitsigns.nvim", -- fancy git decorations
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
		},
	},

	{
		"stevearc/dressing.nvim", -- better ui elements
		event = "VeryLazy",
		opts = {
			input = {
				win_options = {
					winblend = 0,
				},
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim", -- adds indentation guides
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			exclude = { filetypes = { "help", "Trouble", "lazy" } },
			indent = {
				tab_char = "│",
				char = "│",
			},
			scope = {
				show_start = false,
				show_end = false,
			},
		},
		config = function(_, opts)
			vim.opt.list = true
			vim.opt.listchars:append("eol:↴")
			require("ibl").setup(opts)
		end,
	},

	{
		"folke/persistence.nvim", -- session management
		event = "BufReadPre",
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore session for current directory",
			},
			{
				"<leader>qS",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore last session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Stop persistence => do not save session on exit",
			},
		},
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
	},
}
