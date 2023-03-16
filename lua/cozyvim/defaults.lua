---@diagnostic disable-next-line: lowercase-global
cozyvim = {
    auto_update = true,
    lsp = {
        format_on_save = true,
        on_attach = {},
        servers = {
            ["cssls"] = {},
            ["html"] = {},
            ["jsonls"] = {},
            ["marksman"] = {},
            ["pyright"] = {},
            ["rust_analyzer"] = {},
            ["tsserver"] = {},
        }
    },
    nls = {
        sources = {
            code_actions = {},
            diagnostics = {},
            formatting = {
                black = true,
            },
            completion = {},
            hover = {},
        },
    },
    dap = {
        -- see https://github.com/jay-babu/mason-nvim-dap.nvim
        opts = {
            ensure_installed = { "python", "codelldb", }, -- see https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
            automatic_installation = false,
            automatic_setup = true,
        },
        auto_open = true,    -- automatically open dap ui on debug start
        auto_close = true,   -- automatically close dap ui on debug stop
        launch_path = nil,   -- path to launch.json file (defaults to .vscode/launch.json in cwd)
        adapters = {},       -- custom mason-nvim-dap adapters/overrides
        configurations = {}, -- custom mason-nvim-dap configurations/overrides
    },
    lazy = {
        spec = {
            { import = "cozyvim.plugins" }, -- core plugins
            -- { import = "custom.plugins" },  -- custom plugins/overrides
        },
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
            },
        },
    },
    icons = {
        lsp = {
            DiagnosticSignError = " ",
            DiagnosticSignWarn  = " ",
            DiagnosticSignHint  = " ",
            diagnosticSignInfo  = " ",
        },
        dap = {
            DapBreakpoint = " ",
            DapBreakpointRejected = " ",
            DapStopped = " ",
        }
    },
}

cozyvim.lsp.servers["lua_ls"] = {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
}
