local plugins = {
    { "nvim-lua/plenary.nvim", },

    { "kyazdani42/nvim-web-devicons", },

    { "folke/which-key.nvim", },

    { "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    { "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.cmd [[colorscheme gruvbox-material]]
        end,
        enabled = cozyvim.colorscheme == "gruvbox-material",
    },

    { "nvim-lualine/lualine.nvim", event = "VeryLazy", config = true },

    { "xiyaowong/virtcolumn.nvim", },

    { "nmac427/guess-indent.nvim", config = true, cmd = { "GuessIndent" }, },

    { "gpanders/editorconfig.nvim", },

    { "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = {
            auto_open = false,
            use_diagnostic_signs = true, -- en
        },
    },

    { "folke/persistence.nvim",
        event = "BufReadPre",
        config = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
    },

    { "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append("eol:↴")
            require("indent_blankline").setup({
                show_end_of_line = true,
            })
        end,
    },

    { "karb94/neoscroll.nvim",
        -- these are the default keys used by neoscroll
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>",
            "<C-y>", "<C-e>", "zt", "zz", "zb" },
        config = true
    },

    { "lewis6991/gitsigns.nvim",
        event = "BufRead",
        config = true,
    },

    { "gelguy/wilder.nvim",
        event = "CmdlineEnter",
        dependencies = { "romgrk/fzy-lua-native", },
        config = function()
            require("cozyvim.core.wilder")
        end,
    },

    -- comments

    { "numToStr/Comment.nvim",
        keys = { "gc", "gb" },
        config = true,
    },

    { "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "BufReadPost",
        keys = { "]t", "[t" },
        config = true,
    },

    -- terminal plugins

    { "akinsho/toggleterm.nvim", version = "*",
        event = "BufWinEnter",
        config = function()
            require("cozyvim.core.toggleterm")
        end,
    },

    -- telescope plugins

    { "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            require("cozyvim.core.telescope")
        end,
    },

    { "nvim-telescope/telescope-ui-select.nvim" },

    { "nvim-telescope/telescope-file-browser.nvim" },

    { "nvim-telescope/telescope-project.nvim", event = "BufWinEnter" },

    -- navigation plugins

    { "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup({
                show_numbers = true, -- Enable "number" for the window while peeking
                show_cursorline = true, -- Enable "cursorline" for the window while peeking
            })
        end,
    },

    { "phaazon/hop.nvim",
        event = "BufRead",
        config = true,
    },

    {
        "akinsho/bufferline.nvim",
        event = "BufWinEnter",
        branch = "main",
        config = function()
            require("cozyvim.core.bufferline")
        end,
    },

    -- treesitter plugins

    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("cozyvim.core.treesitter")
        end,
    },

    { "nvim-treesitter/nvim-treesitter-refactor", },

    { "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({})
        end,
    },

    { "p00f/nvim-ts-rainbow", },

    { "andymass/vim-matchup",
        event = "BufReadPost",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    -- lsp and autocompletion plugins

    { "williamboman/mason-lspconfig.nvim" },

    { "williamboman/mason.nvim",
        config = function()
            require("cozyvim.core.mason")
        end,
    },

    { "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = { "hrsh7th/cmp-nvim-lsp", },
        config = function()
            require("cozyvim.core.lsp")
        end,
    },

    { "lukas-reineke/lsp-format.nvim" },

    { "j-hui/fidget.nvim", config = true, },

    { "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-copilot", -- for copilot
            "onsails/lspkind.nvim", -- vscode-like pictograms
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            require("cozyvim.core.cmp")
        end,
    },

    { "jose-elias-alvarez/null-ls.nvim", },

    { "github/copilot.vim",
        event = "VeryLazy",
    },

    { "windwp/nvim-autopairs", config = true, },

    { "rmagatti/goto-preview",
        config = {
            default_mappings = false
        },
    },

    -- startup screen

    { "goolord/alpha-nvim",
        lazy = false,
        config = function()
            require("cozyvim.core.alpha")
        end,
    },

}

return plugins
