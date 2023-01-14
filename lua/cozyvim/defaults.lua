-- default core settings
cozyvim = {
    colorscheme = "gruvbox-material",
    copilot = {
        enabled = false,
        cmp = false,
    },
    nls = {
        sources = {
            code_actions = {},
            diagnostics = {},
            formatting = {},
            completion = {},
            hover = {},
        },
    },
}

-- default custom settings
custom = {
    plugins = {},
    lsp_servers = {},
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

cozyvim.check_colorschemes = function(tbl)
    return vim.tbl_contains(tbl, cozyvim.colorscheme)
end
