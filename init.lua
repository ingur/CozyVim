require("cozyvim.defaults") -- load cozyvim defaults
require("cozyvim.options")  -- load base neovim opts

pcall(require, "custom")    -- load custom user opts
require("cozyvim.lazy")     -- load lazy.nvim plugin

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("cozyvim.autocmds")
        require("cozyvim.keymaps")
        require("cozyvim.updater")
    end,
})
