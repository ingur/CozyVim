return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        window = {
            border = "rounded"
        },
        defaults = {
            mode = { "n", "v" },
            ["g"] = { name = "+goto" },
            ["]"] = { name = "+next" },
            ["["] = { name = "+prev" },
            ["<leader>t"] = { name = "+toggle" },
            ["<leader>f"] = { name = "+file/find" },
            ["<leader>q"] = { name = "+quit/sessions" },
        }
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register(opts.defaults)
    end
}
