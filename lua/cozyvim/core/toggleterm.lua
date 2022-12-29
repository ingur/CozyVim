local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap
local toggleterm = require("toggleterm")

toggleterm.setup({
    shade_terminals = false,
    open_mapping = "<C-t>",
    size = function(term)
        if term.direction == "horizontal" then
            return 8
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
})

local Terminal = require('toggleterm.terminal').Terminal
local lazygit  = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    count = 0,
    direction = "float",
    on_open = function(term)
        local opts = {
            noremap = true,
            silent = true
        }
        nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', opts) -- restore default
        nvim_buf_set_keymap(term.bufnr, 't', "<C-g>", "<cmd>lua ToggleLazygit()<cr>", opts)
    end
})

function ToggleLazygit()
    lazygit:toggle()
end
