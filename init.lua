require("cozyvim.defaults") -- cozyvim default settings
require("cozyvim.options") -- base neovim options
require("custom").options() -- custom options/cozyvim overrides

-- bootstrap lazy.nvim
require("cozyvim.bootstrap")

-- load plugins
require("cozyvim.lazy")

-- triggered after LazyDone and processing VimEnter autocommands
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("cozyvim.mappings")
    end,
})
