return {

    {
        "nvim-lua/plenary.nvim",
        lazy = true
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            options = { "buffers", "curdir", "tabpages", "winsize", "help" }
        },
    },

    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },

}
