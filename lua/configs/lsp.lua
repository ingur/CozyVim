local lsp_installer = require("nvim-lsp-installer")
local lspsignature = require("lsp_signature")
local lspformat = require("lsp-format")
local lspconfig = require("lspconfig")

lsp_installer.setup({
    automatic_installation = true
})

lspsignature.setup({
    floating_window = false,
    toggle_key = "<A-x>",
    hint_prefix = "🦥 ",
}, 0)

lspformat.setup({})

local on_attach = function(client)
    require("lsp-format").on_attach(client)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

lspconfig["sumneko_lua"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
})

lspconfig["rust_analyzer"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = {
                    "inactive-code"
                }
            }
        }
    },
})

lspconfig["tsserver"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
})

-- additional language servers
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local other_servers = {
    "html",
    "cssls",
    "jsonls",
    "marksman",
}

for _, lsp in ipairs(other_servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

-- load custom language servers
local has_custom, custom = pcall(require, "custom")
if has_custom and custom["lsp_servers"] ~= nil then
    for server, config in pairs(custom.lsp_servers) do
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
    end
end
