local utils = {}

utils.add_keys = function(tbl)
    local new_tbl = {}
    for _, v in ipairs(tbl) do
        new_tbl[v[1]] = v
    end
    return new_tbl
end

utils.open_config = function()
    local custom_dir = vim.fn.stdpath("config") .. "/lua/custom/"
    require("telescope").extensions.file_browser.file_browser({
        cwd = custom_dir
    })
end

return utils
