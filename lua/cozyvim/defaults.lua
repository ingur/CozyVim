cozyvim = {
    colorscheme = "gruvbox-material",
    updater = false, -- automatically keep CozyVim up to date
    setup_auto_root = true, -- setup auto root using mini.misc (if available)
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
        on_attach = {}, -- add custom on_attach methods here
        servers = {}, -- lsp servers settings/overrides
    },
    cmp = {
        auto_select = false, -- auto select first cmp item on confirm
    },
    term = {
        direction = "horizontal", -- default ToggleTerm direction
    },
    copilot = { -- GitHub Copilot settings
        enabled = false, -- enable the copilot plugin
        cmp = false, -- enable copilot autocompletions
    },
    plugins = {}, -- custom plugins/overrides
    lazy = {}, -- lazy.nvim settings
    keys = { -- see cozyvim.mappings for defaults
        insert_mode = {},
        normal_mode = {},
        term_mode = {},
        visual_mode = {},
        visual_block_mode = {},
        command_mode = {},
        operator_pending_mode = {},
    },
    utils = require("cozyvim.utils"), -- utility functions
}

cozyvim.lazy = {
    spec = {
        { import = "cozyvim.plugins" }, -- core plugins
        { import = "cozyvim.colorschemes" }, -- preinstalled colorschemes
        { import = "cozyvim.custom" }, -- custom plugins/overrides loader
        -- { import = "custom.plugins" }, -- custom plugins/overrides separate spec
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
