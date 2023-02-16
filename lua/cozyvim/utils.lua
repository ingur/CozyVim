local utils = {}

utils.add_keys = function(tbl)
    local new_tbl = {}
    for _, v in ipairs(tbl) do
        new_tbl[v[1]] = v
    end
    return new_tbl
end

return utils
