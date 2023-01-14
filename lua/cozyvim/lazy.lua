local plugins = cozyvim.add_keys(require("cozyvim.plugins"))
plugins = vim.tbl_deep_extend("force", plugins, cozyvim.add_keys(custom.plugins))
plugins = vim.tbl_values(plugins)

local options = {
	defaults = { lazy = true },
	install = { colorscheme = { "habamax" } },
	-- checker = { enabled = true },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}

require("lazy").setup(plugins, options)
