return {

    -- colorscheme plugins

    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_current_word = "bold"
            vim.g.gruvbox_material_transparent_background = 2
            vim.cmd("colorscheme gruvbox-material")
        end,
    },

    -- editor plugins

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
                basic = true,
                windows = true,
                option_toggle_prefix = "<leader>t",
            },
        },
        config = function(_, opts)
            require("mini.basics").setup(opts)
        end,
    },

    {
        "echasnovski/mini.misc",
        version = "*",
        config = function(_, opts)
            local MiniMisc = require("mini.misc")
            MiniMisc.setup(opts)
            MiniMisc.setup_auto_root()
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
        "rmagatti/goto-preview",
        lazy = true,
        opts = {
            default_mappings = false,
        },
    },

    {
        "romainl/vim-cool",
        event = "BufRead",
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        event = "BufReadPost",
        opts = {
            ---@diagnostic disable-next-line: unused-local
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end
        },
        config = function(_, opts)
            vim.o.foldcolumn = "0" -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            require("ufo").setup(opts)
        end,
    },

    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            highlight = {
                keyword = "fg",
            },
            colors = {
                info = { "Purple" }
            },
        },
    },

    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = {
            auto_open = false,
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
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-project.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        opts = {
            extensions_list = { "ui-select", "file_browser", "project", "fzf" },
            extensions = {
                file_browser = {
                    grouped = true,
                },
            },
        },
        config = function(_, opts)
            require("cozyvim.configs.telescope").setup(opts)
        end
    },

    -- coding plugins

    {
        "L3MON4D3/LuaSnip",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = false,
            delete_check_events = "TextChanged",
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = false,
        },
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/nvim-cmp",
            "onsails/lspkind.nvim",
            "saadparwaiz1/cmp_luasnip",
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end,
            },
        },
        config = function(_, opts)
            require("cozyvim.configs.cmp").setup(opts)
        end,
    },

    {
        "nacro90/numb.nvim",
        event = "BufRead",
        opts = {
            show_numbers = true,
            show_cursorline = true,
        },
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    {
        'echasnovski/mini.splitjoin',
        version = false,
        opts    = {
            mappings = { toggle = "gS" },
        },
        config  = function(_, opts)
            require("mini.splitjoin").setup(opts)
        end,
    },

    {
        "echasnovski/mini.bracketed",
        version = false,
        config = function(_, opts)
            require("mini.bracketed").setup(opts)
        end,
    },

    {
        "echasnovski/mini.move",
        version = false,
        opts = {
            mappings = {
                left = '<C-h>',
                right = '<C-l>',
                down = '<C-j>',
                up = '<C-k>',
                line_left = '<C-h>',
                line_right = '<C-l>',
                line_down = '<C-j>',
                line_up = '<C-k>',
            },
        },
        config = function(_, opts)
            require("mini.move").setup(opts)
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
                add = "gsa",            -- Add surrounding in Normal and Visual modes
                delete = "gsd",         -- Delete surrounding
                find = "gsf",           -- Find surrounding (to the right)
                find_left = "gsF",      -- Find surrounding (to the left)
                highlight = "gsh",      -- Highlight surrounding
                replace = "gsr",        -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function(_, opts)
            require('Comment').setup(opts)
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
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            filetype_exclude = { "help", "alpha", "neo-tree", "Trouble", "lazy" },
            show_trailing_blankline_indent = false,
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
    },

    -- treesitter plugins

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "HiPhish/nvim-ts-rainbow2"
        },
        opts = {
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            context_commentstring = {
                enable = true,
                enable_autocmd = false
            },
            ensure_installed = {
                "c",
                "cpp",
                "bash",
                "go",
                "help",
                "html",
                "javascript",
                "jsonc",
                "json",
                "lua",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "rust",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "zig",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
            rainbow = {
                enable = true,
                query = {
                    'rainbow-parens',
                    html = 'rainbow-tags',
                    latex = 'rainbow-blocks',
                },
                hlgroups = {
                    "TSRainbowRed",
                    "TSRainbowOrange",
                    "TSRainbowYellow",
                    "TSRainbowGreen",
                    "TSRainbowCyan",
                    "TSRainbowBlue",
                    "TSRainbowViolet",
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            vim.cmd([[
                highlight TSRainbowRed guifg=#ea6962 ctermfg=Red
                highlight TSRainbowOrange guifg=#e78a4e ctermfg=Green
                highlight TSRainbowYellow guifg=#d8a657 ctermfg=Yellow
                highlight TSRainbowGreen guifg=#a9b665 ctermfg=Blue
                highlight TSRainbowCyan guifg=#89b482 ctermfg=Magenta
                highlight TSRainbowBlue guifg=#7daea3 ctermfg=Cyan
                highlight TSRainbowViolet guifg=#d3869b ctermfg=White
            ]])
        end,
    },

    -- lsp plugins

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "folke/neoconf.nvim",
                cmd = "Neoconf",
                config = true
            },
            {
                "folke/neodev.nvim",
                opts = {
                    experimental = { pathStrict = true }
                }
            },
            {
                "lukas-reineke/lsp-format.nvim",
                config = true,
            },
            "mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            require("cozyvim.configs.lsp")
        end,
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },

    -- debugging plugins

    {
        "mfussenegger/nvim-dap",
        lazy = true,
        dependencies = {
            "mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        cmd = {
            "DapContinue",
            "DapInstall",
            "DapUninstall",
            "DapLoadLaunchJSON",
            "DapRestartFrame",
            "DapSetLogLevel",
            "DapShowLog",
            "DapStepInto",
            "DapStepOver",
            "DapTerminate",
            "DapToggleBreakpoint",
            "DapToggleRepl",
        },
        config = function()
            require("cozyvim.configs.dap")
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        config = function(_, opts)
            require("dapui").setup(opts)
        end,
    },

    -- ui plugins

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
            },
            sections = {
                lualine_x = {
                    function()
                        local current_line = vim.fn.line(".")
                        local current_column = vim.fn.col(".")
                        return "Ln " .. current_line .. " Col " .. current_column
                    end
                },
                lualine_y = {
                    { "filetype" },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
        },
    },

    {
        "SmiteshP/nvim-navic",
        config = function()
            vim.g.navic_silence = true
            vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
            table.insert(cozyvim.lsp.on_attach, function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
            end)
        end,
    },

    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                progress = {
                    enabled = false,
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            messages = {
                view_search = false,
            },
            presets = {
                long_message_to_split = true,
                command_palette = true,
                bottom_search = true,
            },
        },
    },

    {
        "j-hui/fidget.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            window = {
                relative = "editor",
                blend = 0,
            }
        }
    },

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            require("cozyvim.configs.alpha")
        end,
    },


    {
        "MunifTanjim/nui.nvim",
        lazy = true,
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    -- util plugins

    {
        "nvim-lua/plenary.nvim",
        lazy = true
    },

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },

    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {
            options = {
                "buffers",
                "curdir",
                "tabpages",
                "winsize",
                "help",
                "blank",
                "terminal",
                "folds",
                "tabpages"
            },
        },
    },

    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },

}
