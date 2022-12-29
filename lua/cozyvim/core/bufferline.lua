local bufferline = require("bufferline")

local config = {
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
}

bufferline.setup(config)
