local function check_colorschemes(tbl)
    return vim.tbl_contains(tbl, cozyvim.colorscheme)
end

return {

    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.g.gruvbox_material_better_performance = 1
            vim.cmd("colorscheme " .. cozyvim.colorscheme)
        end,
        enabled = cozyvim.colorscheme == "gruvbox-material",
    },

    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.g.everforest_better_performance = 1
            vim.cmd("colorscheme " .. cozyvim.colorscheme)
        end,
        enabled = cozyvim.colorscheme == "everforest",
    },

    {
        "olimorris/onedarkpro.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme " .. cozyvim.colorscheme)
        end,
        enabled = check_colorschemes({
            "onedark",
            "onelight",
            "onedark_vivid",
            "onedark_dark",
        }),
    },

    {
        "rmehri01/onenord.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme " .. cozyvim.colorscheme)
        end,
        enabled = cozyvim.colorscheme == "onenord",
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme " .. cozyvim.colorscheme)
        end,
        enabled = check_colorschemes({
            "tokyonight",
            "tokyonight-night",
            "tokyonight-storm",
            "tokyonight-day",
            "tokyonight-moon",
        }),
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme " .. cozyvim.colorscheme)
        end,
        enabled = check_colorschemes({
            "catppuccin",
            "catppuccin-latte",
            "catppuccin-frappe",
            "catppuccin-macchiato",
            "catppuccin-mocha",
        }),
    },

}
