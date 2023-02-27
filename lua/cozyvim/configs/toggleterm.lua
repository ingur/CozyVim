local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap
local toggleterm = require("toggleterm")

local key_opts = {
    noremap = true,
    silent = true,
}

toggleterm.setup({
    shade_terminals = false,
    open_mapping = "<C-t>",
    direction = cozyvim.term.direction,
    size = function(term)
        if term.direction == "horizontal" then
            return 8
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    on_open = function(term)
        nvim_buf_set_keymap(term.bufnr, 'n', '<C-p>', '<C-w><C-T><cmd>BufferLinePick<cr>', key_opts)
    end,
})

local terminal = require('toggleterm.terminal').Terminal
local lazy_terms = {}
local count = 1337

function _G._toggle_lazygit()
    local cwd = vim.fn.getcwd()
    if lazy_terms[cwd] then
        lazy_terms[cwd]:toggle()
    else
        local lazygit = terminal:new({
            cmd = "lazygit",
            count = count,
            direction = "float",
            on_open = function(term)
                nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', key_opts) -- restore default
                nvim_buf_set_keymap(term.bufnr, 't', "<C-g>", "<cmd>lua _toggle_lazygit()<cr>", key_opts)
            end
        })
        lazy_terms[cwd] = lazygit
        count = count + 1
        lazygit:toggle()
    end
end
