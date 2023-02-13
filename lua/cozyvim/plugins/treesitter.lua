return {

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
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
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

}
