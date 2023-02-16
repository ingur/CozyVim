cozyvim = {
    colorscheme = "gruvbox-material",
    updater = true, -- automatically keep CozyVim up to date
    copilot = { -- GitHub Copilot settings
        enabled = false,
        cmp = false,
    },
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
    lazy = {}, -- lazy.nvim settings
    keys = {}, -- see cozyvim.mappings for defaults
    utils = {}, -- utility functions
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

cozyvim.utils.add_keys = function(tbl)
    local new_tbl = {}
    for _, v in ipairs(tbl) do
        new_tbl[v[1]] = v
    end
    return new_tbl
end
