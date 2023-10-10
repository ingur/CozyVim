return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = function()
        local function toggle_term()
            vim.cmd('execute v:count . "ToggleTerm direction=' .. __toggleterm_direction .. '"')
        end

        local function toggle_direction()
            local visible = false
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if string.find(vim.fn.bufname(buf), "^term://") then
                    visible = true
                end
            end
            if visible then vim.cmd("ToggleTerm") end
            _G.__toggleterm_direction = __toggleterm_direction == "vertical" and "horizontal" or "vertical"
            if visible then toggle_term() end
        end

        return {
            { "<C-t>",      toggle_term,                      desc = "Toggle terminal",          mode = { "n", "i" } },
            { "<C-t>",      "<cmd>ToggleTerm<cr>",            desc = "Toggle terminal",          mode = "t" },
            { "<C-g>",      "<cmd>lua _toggle_lazygit()<cr>", desc = "Toggle lazygit" },
            { "<leader>tt", toggle_direction,                 desc = "Toggle terminal direction" },
        }
    end,
    opts = {
        shade_terminals = false,
        open_mapping = nil,
        persist_mode = false,
        float_opts = {
            border = "rounded",
        },
        size = function(term)
            if term.direction == "horizontal" then
                return 8
            elseif term.direction == "vertical" then
                return vim.o.columns * 0.25
            end
        end
    },
    config = function(_, opts)
        local toggleterm = require("toggleterm")
        toggleterm.setup(opts)

        local terminal = require("toggleterm.terminal").Terminal
        local lazygits = {}
        local count = 1337

        _G.__toggleterm_direction = "horizontal"

        local key_opts = { noremap = true, silent = true }
        function _G._toggle_lazygit()
            local cwd = vim.fn.getcwd()
            if lazygits[cwd] then
                lazygits[cwd]:toggle()
            else
                local lazygit = terminal:new({
                    cmd = "lazygit",
                    count = count,
                    hidden = true,
                    direction = "float",
                    on_open = function(term)
                        vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', key_opts) -- restore default
                        vim.api.nvim_buf_set_keymap(term.bufnr, 't', "<C-g>", "<cmd>lua _toggle_lazygit()<cr>", key_opts)
                        vim.api.nvim_buf_set_keymap(term.bufnr, 't', "<C-t>", "<cmd>lua _toggle_lazygit()<cr>", key_opts)
                    end
                })
                lazygits[cwd] = lazygit
                count = count + 1
                lazygit:toggle()
            end
        end
    end
}
