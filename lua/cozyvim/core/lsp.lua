local lspconfig = require("lspconfig")
local nls = require("null-ls")

require("mason")
local mason_nls = require("mason-null-ls")

-- https://github.com/folke/dot/blob/master/config/nvim/lua/config/plugins/null-ls.lua
local function has_nls_formatter(buf)
    local sources = require("null-ls.sources")
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    return #sources.get_available(ft, "NULL_LS_FORMATTING") > 0
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local nls_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client) return client.name == "null-ls" end,
        bufnr = bufnr,
    })
end

-- formatting on save callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, buf)
    if has_nls_formatter(buf) then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = buf })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = buf,
            callback = function()
                nls_formatting(buf)
            end,
        })
    else
        require("lsp-format").on_attach(client)
    end
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
local options = cozyvim.nls
options.capabilities = capabilities
options.on_attach = on_attach

-- load custom null-ls sources
local sources = vim.deepcopy(options.sources)
options.sources = {}

for group, list in pairs(sources) do
    for source, config in pairs(list) do
        if type(config) == "table" then
            table.insert(options.sources, nls.builtins[group][source].with(config))
        elseif config == true then
            table.insert(options.sources, nls.builtins[group][source])
        end
    end
end

nls.setup(options)

mason_nls.setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
})
