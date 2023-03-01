return {

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
            if cozyvim.setup_auto_root then
                MiniMisc.setup_auto_root()
            end
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
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree"
            },
        },
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                ---@diagnostic disable-next-line: param-type-mismatch
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
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
                map({ "n", "v" }, "<leader>gss", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>gsr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>gsS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>gsu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>gsR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>gsp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>gsb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>gsd", gs.diffthis, "Diff This")
                map("n", "<leader>gsD", function() gs.diffthis("~") end, "Diff This ~")
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
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        opts = {
            extensions_list = { "ui-select", "file_browser", "project", "fzf" }
        },
        config = function(_, opts)
            require("cozyvim.configs.telescope").setup(opts)
        end
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        event = "BufWinEnter",
        config = function()
            require("cozyvim.configs.toggleterm")
        end,
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
        event = { "InsertEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/nvim-cmp",
            "onsails/lspkind.nvim", -- vscode-like pictograms
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
        "echasnovski/mini.bracketed",
        version = false,
        config = function(_, opts)
            require("mini.bracketed").setup(opts)
        end,
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
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
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
        enabled = cozyvim.copilot.enabled,
    },

    -- treesitter plugins

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "mrjones2014/nvim-ts-rainbow",
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
                -- "gitignore", -- requires tree-sitter cli (cargo)
                "bash",
                "help",
                "html",
                "javascript",
                "jsonc",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "rust",
                "zig",
                "cpp",
                "go",
                "c",
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
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
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
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            require("cozyvim.configs.servers")
            require("cozyvim.configs.lsp")
        end,
    },

    -- debugging plugins
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            require("cozyvim.configs.dap").setup()
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        config = function()
            require("cozyvim.configs.dap").setup_ui()
        end,
    },

    -- ui plugins

    {
        "kyazdani42/nvim-web-devicons",
        lazy = true,
    },

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
                    { "encoding", separator = " ",
                        padding = { left = 1, right = 0 } },
                    { "filetype", padding = { left = 0, right = 1 } },
                },
                lualine_y = {
                    { "progress", separator = " ",
                        padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            extensions = { "neo-tree" },
        },
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                always_show_bufferline = false,
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo Tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            }
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
        dependencies = {
            "MunifTanjim/nui.nvim"
        },
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
        config = true,
    },

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            require("cozyvim.configs.alpha")
        end,
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
            options = { "buffers", "curdir", "tabpages", "winsize", "help" }
        },
    },

    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },

}
