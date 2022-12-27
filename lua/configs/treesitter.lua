local treesitter = require("nvim-treesitter.configs")

local options = {

    -- ensure_installed = "all",
    --
    -- ignore_install = { "d" },

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
        "gitignore",
        "javascript",
        "markdown_inline",
    },

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
