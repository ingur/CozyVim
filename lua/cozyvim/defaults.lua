cozyvim = {
    colorscheme = "gruvbox-material",
    updater = true, -- automatically keep CozyVim up to date
    nls = { -- null-ls settings
        sources = {
            code_actions = {},
            diagnostics = {},
            formatting = {},
            completion = {},
            hover = {},
        },
    },
    lsp = {
        format_on_save = true,
        on_attach = {},
        servers = {},
    },
    copilot = { -- GitHub Copilot settings
        enabled = false,
        cmp = false,
    },
    lazy = {}, -- lazy.nvim settings
    keys = {}, -- see cozyvim.mappings for defaults
    utils = require("cozyvim.utils"), -- utility functions
}

cozyvim.lazy = {
    spec = {
        { import = "cozyvim.plugins" }, -- core plugins
        { import = "custom.plugins" }, -- custom plugins/overrides
        -- { import = "cozyvim.plugins.extras.module_name"} -- extra module example
    },
    lockfile = vim.fn.stdpath("config") .. "/lua/custom/lazy-lock.json",
    defaults = {
        lazy = false,
        version = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        }
    }
}
