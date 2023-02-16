return {

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
        },
    },

    {
        "echasnovski/mini.basics",
        opts = {
            options = {
                basic = false,
            },
            mappings = {
                windows = true,
            },
        },
        config = function(_, opts)
            require("mini.basics").setup(opts)
        end,
    },

    {
        "echasnovski/mini.bufremove",
        lazy = true,
    },

    {
        "karb94/neoscroll.nvim",
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        config = true,
    },

    {
        "phaazon/hop.nvim",
        branch = "v2",
        event = "BufRead",
        config = true
    },

    {
        "windwp/nvim-spectre",
        lazy = true,
    },

    {
        "rmagatti/goto-preview",
        lazy = true,
        opts = {
            default_mappings = false,
        },
    },


    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            auto_open = false,
            use_diagnostic_signs = true,
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "契" },
                topdelete = { text = "契" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
            end,
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-project.nvim",
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("ui-select")
            telescope.load_extension("file_browser")
            telescope.load_extension("project")
        end,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        event = "BufWinEnter",
        config = function()
            local nvim_buf_set_keymap = vim.api.nvim_buf_set_keymap
            local toggleterm = require("toggleterm")

            local key_opts = {
                noremap = true,
                silent = true,
            }

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
                on_open = function(term)
                    nvim_buf_set_keymap(term.bufnr, 'n', '<C-p>', '<C-w>w<cmd>BufferLinePick<cr>', key_opts)
                end,
            })

            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit  = Terminal:new({
                cmd = "lazygit",
                hidden = true,
                count = 0,
                direction = "float",
                on_open = function(term)
                    vim.cmd("startinsert!")
                    nvim_buf_set_keymap(term.bufnr, 't', '<esc>', '<esc>', key_opts) -- restore default
                    nvim_buf_set_keymap(term.bufnr, 't', "<C-g>", "<cmd>lua _toggle_lazygit()<cr>", key_opts)
                end
            })

            function _toggle_lazygit()
                lazygit:toggle()
            end
        end,
    },

}
