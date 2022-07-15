-- load base nvim options
require("options")

--- ensure packer is installed, and returns whether we need to sync after bootstrap
local function bootstrap()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path })
        return false
    end
    return true
end

local synced = bootstrap()

if synced then
    require("impatient")
    vim.g.coq_settings = {
        auto_start = "shut-up"
    }
    vim.notify = require("notify")
end

vim.cmd("packadd packer.nvim")
local packer = require("packer")

packer.init({
    auto_clean           = true,
    compile_on_sync      = true,
    auto_reload_compiled = true,
    git                  = { clone_timeout = 6000 },
    display              = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
})

-- load plugins
local plugins = require("plugins")
packer.startup(function(use)
    for _, plugin in pairs(plugins) do
        use(plugin)
    end
end)

if not synced then
    packer.sync()
end
