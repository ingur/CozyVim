local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
    [[                                   _          ]],
    [[  _____ ____  ____  __  __ _   __ (_)____ ___ ]],
    [[ / ___// __ \/_  / / / / /| | / // // __ `__ \]],
    [[/ /__ / /_/ / / /_/ /_/ / | |/ // // / / / / /]],
    [[\___/ \____/ /___/\__, /  |___//_//_/ /_/ /_/ ]],
    [[                 /____/                       ]],
}

dashboard.section.buttons.val = {
    dashboard.button("f", " > Find File", "<cmd>Telescope find_files<CR>"),
    dashboard.button("e", " > New File", "<cmd>ene <BAR> startinsert <CR>"),
    dashboard.button("r", " > Recent Files", "<cmd>Telescope oldfiles<CR>"),
    dashboard.button("p", " > Project Browser", "<cmd>Telescope project<CR>"),
    dashboard.button("s", " > Restore Last Session", [[<cmd>lua require("persistence").load({ last = true })<cr>]]),
    dashboard.button("l", " > Manage Plugins", "<cmd>Lazy<CR>"),
    dashboard.button("x", " > CozyVim Config", "<cmd>lua cozyvim.utils.open_config()<cr>"),
    dashboard.button("q", " > Quit", "<cmd>qa<CR>"),
}

local function footer()
    local total_plugins = "   " .. require("lazy").stats().count .. " plugins"
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "  ❤ v" .. version.major .. "." .. version.minor .. "." .. version.patch

    return datetime .. total_plugins .. nvim_version_info
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Constant"

-- close Lazy and re-open when the dashboard is ready
if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
            require("lazy").show()
        end,
    })
end

alpha.setup(dashboard.config)
