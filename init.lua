require("cozyvim.options")
require("cozyvim.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("cozyvim.autocmds")
        require("cozyvim.mappings")
        require("cozyvim.updater")
    end,
})
