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

function _G.set_terminal_keymaps()
    local opts = {
        noremap = true,
        silent = true,
    }
    nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
    nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
    nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
    nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
    nvim_buf_set_keymap(0, 't', '<C-Up>', [[<C-\><C-n><cmd>resize +2<cr>i]], opts)
    nvim_buf_set_keymap(0, 't', '<C-Down>', [[<C-\><C-n><cmd>resize -2<cr>i]], opts)
    nvim_buf_set_keymap(0, 't', '<C-Left>', [[<C-\><C-n><cmd>vertical resize +2<cr>i]], opts)
    nvim_buf_set_keymap(0, 't', '<C-Right>', [[<C-\><C-n><cmd>vertical resize -2<cr>i]], opts)
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
        -- nvim_buf_set_keymap(term.bufnr, 't', 'q', "<cmd>close<cr>", opts)
    end
})

function ToggleLazygit()
    lazygit:toggle()
end
