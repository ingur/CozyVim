return {

    {
        "kyazdani42/nvim-web-devicons",
        lazy = true
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = true
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
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
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

}
