return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	keys = {
		{ "<leader>;", "<cmd>Alpha<cr>", desc = "Dashboard" },
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[                                   _          ]],
			[[  _____ ____  ____  __  __ _   __ (_)____ ___ ]],
			[[ / ___// __ \/_  / / / / /| | / // // __ `__ \]],
			[[/ /__ / /_/ / / /_/ /_/ / | |/ // // / / / / /]],
			[[\___/ \____/ /___/\__, /  |___//_//_/ /_/ /_/ ]],
			[[                 /____/                       ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "󰈞  Find File", "<cmd>Telescope file_browser<cr>"),
			dashboard.button("e", "  New File", "<cmd>ene <BAR> startinsert <cr>"),
			dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
			dashboard.button("p", "  Project Browser", "<cmd>Telescope project<cr>"),
			dashboard.button(
				"s",
				"  Restore Last Session",
				[[<cmd>lua require("persistence").load({ last = true })<cr>]]
			),
			dashboard.button("l", "󰒲  Manage Plugins", "<cmd>Lazy<cr>"),
			dashboard.button(
				"x",
				"  Configuration",
				[[<cmd>lua require('telescope.builtin').find_files({cwd=vim.fn.stdpath("config")})<cr>]]
			),
			dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
		}

		dashboard.section.footer.opts.hl = "Constant"

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		alpha.setup(dashboard.config)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = "neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
