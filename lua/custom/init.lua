-- custom.lua - allows for quick customization of CozyVim

-- change colorscheme, see README.md for available colorschemes
-- cozyvim.colorscheme = "gruvbox-material"

-- enable copilot plugin and autocompletion source
-- cozyvim.copilot.enabled = true
-- cozyvim.copilot.cmp = true

-- enable null-ls sources
-- see https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
-- cozyvim.nls.sources.formatting.black = true
-- cozyvim.nls.sources.formatting.black = {
--     filetypes = { "python" },
-- }
-- cozyvim.nls.sources.formatting.lua_format = true

custom.plugins = {
    -- add custom plugins here, see https://github.com/folke/lazy.nvim for plugin spec
    -- {
    --     "xiyaowong/nvim-transparent",
    --     lazy = false,
    --     config = function()
    --         require("transparent").setup({
    --             enable = true
    --         })
    --     end,
    -- }
}

custom.lsp_servers = {
    -- add custom lsp-servers here
    -- see https://github.com/williamboman/mason-lspconfig.nvim for available LSP's
}
