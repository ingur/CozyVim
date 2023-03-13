local lspkind = require("lspkind")
local luasnip = require("luasnip")
local cmp = require("cmp")

local M = {}

M.has_words_before = function()
    ---@diagnostic disable-next-line: deprecated
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.defaults = {
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping(function(fallback)
            local entry = cmp.get_selected_entry()
            if entry then
                if entry.source.name == "copilot" then
                    cmp.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    })
                else
                    cmp.confirm({ select = false })
                end
            else
                fallback()
            end
        end),
        ["<C-Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.close()
            elseif M.has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and M.has_words_before() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() and M.has_words_before() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            symbol_map = { Copilot = "" },
        }),
    },
    sources = cmp.config.sources({
        { name = "path",     group_index = 1 },
        { name = "nvim_lsp", group_index = 1 },
        { name = "copilot",  group_index = 1 },
        { name = "buffer",   group_index = 2 },
        { name = "luasnip",  group_index = 3, keyword_length = 3 },
    }),
}

M.setup = function(options)
    options = vim.tbl_deep_extend("force", M.defaults, options or {})
    cmp.setup(options)

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })
end

return M
