local M = {}

M.defaults = {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        path_display = { "truncate" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        mappings = {
            n = { ["q"] = require("telescope.actions").close },
            i = { ["<C-c>"] = require("telescope.actions").close },
        },
    },
    extensions_list = { "themes", "terms" },
}

M.setup = function(options)
    options = vim.tbl_deep_extend("force", M.defaults, options or {})

    local telescope = require("telescope")
    telescope.setup(options)

    for _, extension in ipairs(options.extensions_list) do
        telescope.load_extension(extension)
    end
end

return M
