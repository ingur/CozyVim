local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

require("mason")
local mason_null_ls = require("mason-null-ls")

local on_attach = function(client)
    require("lsp-format").on_attach(client)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
    ["html"] = {},
    ["cssls"] = {},
    ["jsonls"] = {},
    ["marksman"] = {},
    ["pyright"] = {},
}

servers["sumneko_lua"] = {
    settings = {
        Lua = {
            completion = {
                keywordSnippet = "Disable",
            },
            diagnostics = {
                globals = { "vim" },
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

-- add custom language servers
local has_custom, custom = pcall(require, "custom")
if has_custom and custom["lsp_servers"] ~= nil then
    servers = vim.tbl_deep_extend("force", servers, custom["lsp_servers"])
end

for server, config in pairs(servers) do
    if config ~= nil then
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
    end
end

-- load null-ls
local options = {}
options.capabilities = capabilities
options.on_attach = on_attach

-- allow users to add custom settings
custom.null_ls(null_ls, options)

null_ls.setup(options)

mason_null_ls.setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
})
