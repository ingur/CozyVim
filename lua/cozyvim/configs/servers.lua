-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
local servers = {
    ["html"] = {},
    ["cssls"] = {},
    ["jsonls"] = {},
    ["marksman"] = {},
    ["pyright"] = {},
    ["rust_analyzer"] = {},
    ["tsserver"] = {},
}

servers["lua_ls"] = {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
}

-- add custom language servers/overrides
cozyvim.lsp.servers = vim.tbl_deep_extend("force", servers, cozyvim.lsp.servers)
