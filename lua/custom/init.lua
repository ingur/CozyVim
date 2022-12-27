local custom = {}

custom.options = function()
    -- overwrite or set custom options here, e.g:
    -- local opt = vim.opt
    -- local g = vim.g
    -- g.mapleader = ","
end

custom.plugins = {
    -- add custom plugins here, e.g:
    -- { "alec-gibson/nvim-tetris", cmd = "Tetris" },
}

custom.keymaps = function(wk)
    -- add custom keymaps here, e.g:
    -- wk.register({
    --     ["<leader>wk"] = { "<cmd>WhichKey<cr>", "open whichkey" },
    -- })
end

custom.lsp_servers = {
    -- add custom lsp servers here
    -- see: https://github.com/williamboman/nvim-lsp-installer#available-lsps
    -- ["jedi_language_server"] = {
    --     settings = {},
    -- },
}

return custom
