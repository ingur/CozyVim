return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
        local mode_color = function()
            local colors = {
                n = "#7daea3",
                i = "#a9b665",
                c = "#d3869b",
                v = "#ea6962",
                V = "#ea6962",
                R = "#e78a4e",
                t = "#89b482",
            }
            local mode = vim.fn.mode()
            return { bg = colors[mode] and colors[mode] or "#a89984" }
        end
        return {
            options = {
                theme = "auto",
                globalstatus = true,
                section_separators = { left = " ", right = "" },
                component_separators = { left = "/" },
            },
            sections = {
                lualine_a = {
                    { "mode", icon = { "󰟪", align = "left" }, color = mode_color },
                    {
                        function()
                            return " "
                        end,
                        separator = { left = "", right = "" },
                        color = { bg = "#45403d" },
                        padding = 0,
                    },
                },
                lualine_x = {
                    function()
                        local current_line = vim.fn.line(".")
                        local current_column = vim.fn.col(".")
                        return "Ln " .. current_line .. " Col " .. current_column
                    end,
                },
                lualine_y = { "filetype" },
                lualine_z = { { "' ' .. os.date('%R')", color = mode_color } },
            },
        }
    end,
}

