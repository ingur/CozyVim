local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_nls = require("mason-null-ls")
local lspconfig = require("lspconfig")
local nls = require("null-ls")

mason.setup()

-- https://github.com/folke/dot/blob/master/config/nvim/lua/config/plugins/null-ls.lua
local function has_nls_formatter(buf)
    local sources = require("null-ls.sources")
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    return #sources.get_available(ft, "NULL_LS_FORMATTING") > 0
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local nls_formatting = function(bufnr)
    if not cozyvim.lsp.format_on_save then return end
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

-- formatting on save callback
local lsp_format = require("lsp-format")
local format = lsp_format.format

---@diagnostic disable-next-line: duplicate-set-field
lsp_format.format = function(options)
    if not cozyvim.lsp.format_on_save then return end
    return format(options)
end

local augroup = vim.api.nvim_create_augroup("LspFormat", {})
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
        lsp_format.on_attach(client)
    end
end)

-- initialize capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
    for _, fn in ipairs(cozyvim.lsp.on_attach) do
        fn(client, bufnr)
    end
end

local function setup(server)
    local config = vim.tbl_deep_extend("force", {
        capabilities = vim.deepcopy(capabilities),
        on_attach = on_attach,
    }, cozyvim.lsp.servers[server] or {})
    lspconfig[server].setup(config)
end

local available = mason_lspconfig.get_available_servers()
local ensure_installed = {}
for server, config in pairs(cozyvim.lsp.servers) do
    if config ~= nil then
        if config.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
        else
            table.insert(ensure_installed, server)
        end
    end
end

mason_lspconfig.setup({ ensure_installed = ensure_installed })
mason_lspconfig.setup_handlers({ setup })

-- load null-ls
local options = cozyvim.nls
options.capabilities = capabilities
options.on_attach = on_attach

-- load custom null-ls sources
local sources = vim.deepcopy(options.sources)
options.sources = {}

ensure_installed = {}
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
