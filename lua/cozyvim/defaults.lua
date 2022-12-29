-- default core settings
cozyvim = {
    colorscheme = "gruvbox-material",
}

-- keymapping
cozyvim.keys = {
    normal_mode = {},
    insert_mode = {},
    visual_mode = {},
    term_mode = {},
    visual_block_mode = {},
    command_mode = {},
    operator_pending_mode = {},
}

cozyvim.add_keys = function(tbl)
    local new_tbl = {}
    for _, v in ipairs(tbl) do
        new_tbl[v[1]] = v
    end
    return new_tbl
end
