return {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    config = function()
        local function lazyload(module, config)
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    require(module).setup(config)
                end,
            })
        end

        require("mini.basics").setup({
            options = {
                basic = false,
            },
            mappings = {
                basic = true,
                windows = true,
                option_toggle_prefix = "<leader>t",
                move_with_alt = true,
            },
        })

        require("mini.misc").setup_auto_root()
        require("mini.misc").setup_restore_cursor()

        lazyload("mini.cursorword", {}) -- highlight word on cursor
        lazyload("mini.bufremove", {}) -- easy close buffers
        lazyload("mini.move", {})  -- move lines/selections with alt
    end,
}
