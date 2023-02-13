return {

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/nvim-cmp",
            "onsails/lspkind.nvim", -- vscode-like pictograms
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end,
            },
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            require("cozyvim.plugins.cmp.config")
        end,
    },

}
