require("cozyvim.defaults") -- cozyvim default settings
require("cozyvim.options") -- cozyvim default options
require("custom") -- custom settings/cozyvim overrides

require("cozyvim.lazy") -- bootstrap lazy.nvim & load plugins

-- triggered after LazyDone and processing VimEnter autocommands
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("cozyvim.mappings")
        require("cozyvim.updater")
    end,
})
