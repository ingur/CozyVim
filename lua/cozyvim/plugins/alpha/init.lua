return {

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            require("cozyvim.plugins.alpha.config")
        end,
    },

}
