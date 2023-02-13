local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_nls = require("mason-null-ls")
local lspconfig = require("lspconfig")
local nls = require("null-ls")

mason.setup()

mason_lspconfig.setup({
    automatic_installation = true,
})

-- https://github.com/folke/dot/blob/master/config/nvim/lua/config/plugins/null-ls.lua
local function has_nls_formatter(buf)
    local sources = require("null-ls.sources")
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    return #sources.get_available(ft, "NULL_LS_FORMATTING") > 0
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local nls_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- formatting on save callback
if cozyvim.lsp.format_on_save then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    table.insert(cozyvim.lsp.on_attach, function(client, bufnr)
        if has_nls_formatter(bufnr) then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    nls_formatting(bufnr)
                end,
            })
        else
            require("lsp-format").on_attach(client)
        end
    end)
end

-- initialize capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- TODO: fix snippet support to make it easily configurable
capabilities.textDocument.completion.completionItem.snippetSupport = false

local function on_attach(client, bufnr)
    for _, fn in ipairs(cozyvim.lsp.on_attach) do
        fn(client, bufnr)
    end
end

for server, config in pairs(cozyvim.lsp.servers) do
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
