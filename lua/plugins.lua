local plugins = {
    { "lewis6991/impatient.nvim" },

    { "nvim-lua/plenary.nvim", module = "plenary" },

    { "wbthomason/packer.nvim", opt = true },

    { "nathom/filetype.nvim" },

    { "sainnhe/gruvbox-material",
        config = function()
            vim.opt.background = "dark"
            vim.cmd [[colorscheme gruvbox-material]]
        end,
    },

    { "dstein64/vim-startuptime", opt = true, cmd = "StartupTime" },

    { "nvim-lualine/lualine.nvim", config = function() require("lualine").setup() end },

    { "kyazdani42/nvim-web-devicons", module = "nvim-web-devicons", opt = true },

    { "rcarriga/nvim-notify" },

    { "xiyaowong/virtcolumn.nvim" },

    { "antoinemadec/FixCursorHold.nvim" },

    { "nmac427/guess-indent.nvim",
        config = function()
            require("guess-indent").setup({})
        end,
    },

    -- treesitter plugins

    { "nvim-treesitter/nvim-treesitter",
        config = function()
            require("configs.treesitter")
        end,
        after = "nvim-lspconfig",
        run = ":TSUpdate",
    },

    { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },

    { "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        config = function()
            require("treesitter-context").setup({})
        end,
    },

    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },

    { "andymass/vim-matchup",
        after = "nvim-treesitter",
        event = "CursorMoved",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    { "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- lsp and auto-completion plugins

    { "williamboman/nvim-lsp-installer" },

    { "neovim/nvim-lspconfig",
        after = { "nvim-lsp-installer" },
        requires = {
            { "lukas-reineke/lsp-format.nvim" },
            { "ray-x/lsp_signature.nvim" }
        },
        config = function()
            require("configs.lsp")
        end,
    },

    { "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({})
        end,
    },

    -- { "ms-jpq/coq-nvim", branch = "coq", run = ":COQdeps", },
    -- { "ms-jpq/coq.artifacts", branch = "artifacts", },
    -- { "ms-jpq/coq.thirdparty", branch = "3p" },
    { "hrsh7th/nvim-cmp",
        requires = { 
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-copilot", -- for copilot
            "onsails/lspkind.nvim", -- vscode-like pictograms
            -- "hrsh7th/cmp-vsnip",
            -- "hrsh7th/vim-vsnip",
            "saadparwaiz1/cmp_luasnip",
            {"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"},
        },
    },

    { "github/copilot.vim" },

    { "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
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

    -- Telescope plugins

    { "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            require("configs.telescope")
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
        config = function()
            require("hop").setup({})
        end,
    },

    { "romgrk/barbar.nvim",
        config = function()
            require("bufferline").setup({
                auto_hide = true
            })
        end,
    },


    { "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                default_mappings = true
            })
        end
    },

    { "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        -- cmd = "TroubleToggle",
        config = function()
            require("trouble").setup({})
        end
    },

    -- terminal popups

    { "akinsho/toggleterm.nvim", tag = "v1.*",
        config = function()
            require("configs.toggleterm")
        end,
    },

    -- comment lines

    { "numToStr/Comment.nvim",
        module = "Comment",
        keys = { "gc", "gb" },
        config = function()
            require("Comment").setup({})
        end
    },

    { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
    },

    -- smooth scrolling

    { "karb94/neoscroll.nvim",
        module = "neoscroll",
        -- these are the default keys used by neoscroll
        keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>",
            "<C-y>", "<C-e>", "zt", "zz", "zb" },
        config = function()
            require("neoscroll").setup({})
        end,
    },

    -- startup screen

    { "goolord/alpha-nvim",
        config = function()
            require("configs.alpha")
        end,
    },

    -- session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    },

    -- custom keybindings

    { "folke/which-key.nvim",
        config = function()
            require("configs.which-key")
            require("keymaps")
        end,
    },

}

return plugins
