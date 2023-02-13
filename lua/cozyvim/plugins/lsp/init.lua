return {

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
            "lukas-reineke/lsp-format.nvim",
        },
        config = function()
            require("cozyvim.plugins.lsp.servers")
            require("cozyvim.plugins.lsp.config")
        end,
    },

}
