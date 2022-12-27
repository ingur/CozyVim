local treesitter = require("nvim-treesitter.configs")

local options = {

    ensure_installed = "all",

    --[[ ensure_installed = {
        "c",
        "cpp",
        "css",
        "lua",
        "vim",
        "scss",
        "html",
        "json",
        "rust",
        "python",
        "markdown",
        "gitignore",
        "javascript",
    }, ]]

    auto_install = true,

    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
    },

    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },

    matchup = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    }
}

treesitter.setup(options)
