-- load base nvim options
require("options")

local has_custom, custom = pcall(require, "custom")

if has_custom and custom["options"] ~= nil then
    -- load custom options
    custom.options()
end

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

-- load core plugin table
local plugins = require("plugins")

-- merge with custom plugin table
if has_custom and custom["plugins"] ~= nil and #custom.plugins > 0 then
    plugins = vim.tbl_deep_extend("force", plugins, custom.plugins)
end

packer.startup(function(use)
    for _, plugin in pairs(plugins) do
        use(plugin)
    end
end)

if not synced then
    packer.sync()
end
