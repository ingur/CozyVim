local lsp_installer = require("nvim-lsp-installer")
local lspsignature = require("lsp_signature")
local lspformat = require("lsp-format")
local lspconfig = require("lspconfig")
--[[local coq = require("coq")]]

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

lspconfig["sumneko_lua"].setup(--[[coq.lsp_ensure_capabilities(]] {
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", }
            }
        }
    },
}--[[)]] )

lspconfig["rust_analyzer"].setup(--[[coq.lsp_ensure_capabilities(]] {
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
}--[[)]] )

-- additional language servers
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps

require("coq_3p")({
    {
        src = "copilot",
        short_name = "COP",
        accept_key = "<C-J>"
    },

    {
        src = "nvimlua",
        short_name = "nLUA",
        conf_only = true
    },

    {
        src = "bc",
        short_name = "MATH",
        precision = 6
    }
})
