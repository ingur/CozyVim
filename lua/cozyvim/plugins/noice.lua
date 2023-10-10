return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        messages = {
            view_search = false,
        },
        presets = {
            long_message_to_split = true,
            command_palette = true,
            bottom_search = true,
            lsp_doc_border = true,
        },
        views = {
            mini = {
                win_options = {
                    winblend = 0
                }
            },
            popup = {
                win_options = {
                    winblend = 0,
                }
            }
        }
    },
    config = function(_, opts)
        require("noice").setup(opts)
        -- allows for transparent background (gruvbox), also works on goto-preview, nvim-cmp+documentation, lazy, mason etc.
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828", blend = 0 })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828" })
        vim.api.nvim_set_hl(0, "NoicePopupBorder", { fg = "#928374" })
    end
}
