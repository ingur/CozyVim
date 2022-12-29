local treesitter = require("nvim-treesitter.configs")

local options = {

    -- ensure_installed = "all",

    ensure_installed = {
        "c",
        "go",
        "cpp",
        "css",
        "lua",
        "vim",
        "zig",
        "scss",
        "html",
        "help",
        "json",
        "rust",
        "bash",
        "make",
        "cmake",
        "regex",
        "julia",
        "python",
        "c_sharp",
        "markdown",
        "gitignore",
        "javascript",
        "markdown_inline",
    },

    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 1000, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },

    matchup = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    }
}

treesitter.setup(options)
