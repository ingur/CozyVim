-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
    ["html"] = {},
    ["cssls"] = {},
    ["jsonls"] = {},
    ["marksman"] = {},
    ["pyright"] = {},
}

servers["lua_ls"] = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "cozyvim" },
            },
        },
    },
}

servers["rust_analyzer"] = {
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = {
                    "inactive-code",
                },
            },
        },
    },
}

servers["tsserver"] = {
    init_options = {
        preferences = {
            disableSuggestions = true,
        },
    },
    settings = {
        javascript = {
            format = {
                semicolons = "insert",
            },
        },
    },
}

-- add custom language servers/overrides
cozyvim.lsp.servers = vim.tbl_deep_extend("force", servers, cozyvim.lsp.servers)
