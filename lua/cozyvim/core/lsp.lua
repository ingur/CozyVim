local lspformat = require("lsp-format")
local lspconfig = require("lspconfig")

require("mason")

local on_attach = function(client)
    require("lsp-format").on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
    ["html"] = {},
    ["cssls"] = {},
    ["jsonls"] = {},
    ["marksman"] = {},
}

servers["sumneko_lua"] = {
    settings = {
        Lua = {
            completion = {
                keywordSnippet = "Disable",
            },
            diagnostics = {
                globals = { "vim", }
            }
        }
    },
}

servers["rust_analyzer"] = {
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = {
                    "inactive-code"
                }
            }
        }
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