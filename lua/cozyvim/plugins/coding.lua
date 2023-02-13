return {

    {
        "nacro90/numb.nvim",
        event = "BufRead",
        opts = {
            show_numbers = true,
            show_cursorline = true,
        },
    },

    {
        "echasnovski/mini.pairs",
        version = "*",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },

    {
        "echasnovski/mini.move",
        version = false,
        config = function(_, opts)
            require("mini.move").setup(opts)
        end,
    },

    {
        "echasnovski/mini.comment",
        version = "*",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.comment").setup(opts)
        end,
    },

    {
        "echasnovski/mini.cursorword",
        version = "*",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.cursorword").setup(opts)
        end,
    },

    {
        "echasnovski/mini.ai",
        version = "*",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },

    {
        "echasnovski/mini.surround",
        version = "*",
        keys = function(_, keys)
            local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local mappings = {
                { opts.mappings.add,            desc = "Add surrounding",       mode = { "n", "v" } },
                { opts.mappings.delete,         desc = "Delete surrounding" },
                { opts.mappings.find,           desc = "Find right surrounding" },
                { opts.mappings.find_left,      desc = "Find left surrounding" },
                { opts.mappings.highlight,      desc = "Highlight surrounding" },
                { opts.mappings.replace,        desc = "Replace surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `n-lines`" },
            }
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "gsa", -- Add surrounding in Normal and Visual modes
                delete = "gsd", -- Delete surrounding
                find = "gsf", -- Find surrounding (to the right)
                find_left = "gsF", -- Find surrounding (to the left)
                highlight = "gsh", -- Highlight surrounding
                replace = "gsr", -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },

    {
        "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup()
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "bufread",
        opts = {
            show_current_context = true,
            show_end_of_line = true,
        },
        config = function(_, opts)
            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")
            require("indent_blankline").setup(opts)
        end,
    },

    {
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
        enabled = cozyvim.copilot.enabled,
    },

}
