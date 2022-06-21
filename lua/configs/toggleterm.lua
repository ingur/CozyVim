local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap
local toggleterm = require("toggleterm")

toggleterm.setup({
    shade_terminals = false,
    open_mapping = "<C-t>",
})

function _G.set_terminal_keymaps()
    local opts = {
        noremap = true,
        silent = true,
    }
    nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end

vim.cmd [[autocmd! TermOpen term://* lua set_terminal_keymaps()]]

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
        nvim_buf_set_keymap(term.bufnr, 't', 'q', "<cmd>close<cr>", opts)
    end
})

function ToggleLazygit()
    lazygit:toggle()
end
