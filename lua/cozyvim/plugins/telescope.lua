return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = "Telescope",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-project.nvim",
		"nvim-lua/plenary.nvim",
	},
	keys = function()
		local telescoped = function(builtin, opts)
			local params = { builtin = builtin, opts = opts }
			return function()
				builtin = params.builtin
				opts = params.opts
				local cwd = vim.fn.getcwd()
				local results_title = "Results (" .. string.match(cwd, "/([^/]+)/?$") .. ")"
				opts = vim.tbl_deep_extend("force", { results_title = results_title }, opts or {})
				if builtin == "find_files" then
					if vim.loop.fs_stat(cwd .. "/.git") then
						opts.show_untracked = true
						builtin = "git_files"
					else
						builtin = "find_files"
					end
				end
				require("telescope.builtin")[builtin](opts)
			end
		end
		return {
			{ "<leader>ff", telescoped("find_files"),          desc = "Find files" },
			{ "<leader>fr", telescoped("oldfiles"),            desc = "Find recent files" },
			{ "<leader>fw", telescoped("grep_string"),         desc = "Grep string" },
			{ "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File browser" },
			{ "<leader>fp", "<cmd>Telescope project<cr>",      desc = "Projects" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>",    desc = "Help_tags" },
			{ "<leader>fc", "<cmd>Telescope resume<cr>",       desc = "Continue" },
			{ "<leader>/",  telescoped("live_grep"),           desc = "Live grep" },
		}
	end,
	opts = function()
		return {
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "   ",
				selection_caret = "  ",
				entry_prefix = "  ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				preview = {
					treesitter = false,
					timeout = 250,
					filesize_hook = function(filepath, bufnr, opts)
						local path = require("plenary.path"):new(filepath)
						local height = vim.api.nvim_win_get_height(opts.winid)
						local lines = vim.split(path:head(height), "[\r]?\n")
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
					end,
				},
				path_display = { "truncate" },
				set_env = { COLORTERM = "truecolor" },
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
					i = {
						["<C-c>"] = require("telescope.actions").close,
						["<C-k>"] = require("telescope.actions").move_selection_previous,
						["<C-j>"] = require("telescope.actions").move_selection_next,
						["<C-q>"] = require("telescope.actions").send_selected_to_qflist
								+ require("telescope.actions").open_qflist,
					},
				},
			},
			extensions_list = { "file_browser", "project", "fzf" },
			extensions = {
				file_browser = {
					grouped = true,
				},
			},
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		for _, extension in ipairs(opts.extensions_list) do
			telescope.load_extension(extension)
		end
	end,
}
