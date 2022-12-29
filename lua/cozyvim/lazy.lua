local function add_keys(plugins)
    local tbl = {}
    for _, plugin in ipairs(plugins) do
        tbl[plugin[1]] = plugin
    end
    return tbl
end

local plugins = add_keys(require("cozyvim.plugins"))
plugins = vim.tbl_deep_extend("force", plugins, add_keys(require("custom").plugins))
plugins = vim.tbl_values(plugins)

local options = {
    defaults = { lazy = true },
    install = { colorscheme = { "gruvbox-material", "habamax" } },
    -- checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "python3_provider",
                "python_provider",
                "node_provider",
                "ruby_provider",
                "perl_provider",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            }
        }
    }
}

require("lazy").setup(plugins, options)