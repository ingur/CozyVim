local utils = {
    toggle = {}
}

utils.toggle.format_on_save = function()
    cozyvim.lsp.format_on_save = not cozyvim.lsp.format_on_save
end

utils.telescope = function(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        local cwd = vim.fn.getcwd()
        local results_title = "Results (" .. string.match(cwd, "/([^/]+)/?$") .. ")"
        opts = vim.tbl_deep_extend("force", { results_title = results_title }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat(cwd .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
end

return utils
