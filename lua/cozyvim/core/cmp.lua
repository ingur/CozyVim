local lspkind = require('lspkind')
local cmp = require("cmp")

local luasnip = require("luasnip")

luasnip.config.set_config({
    history = false,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
    enable_autosnippets = false,
})

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    -- enabled = function()
    --     -- disable completion in comments
    --     local context = require 'cmp.config.context'
    --     -- keep command mode completion enabled when cursor is in a comment
    --     if vim.api.nvim_get_mode().mode == 'c' then
    --         return true
    --     else
    --         return not context.in_treesitter_capture("comment")
    --             and not context.in_syntax_group("Comment")
    --     end
    -- end,
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
                path = "[Path]",
                buffer = "[Buf]",
                copilot = "[Cop]",
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
            })
        }),
    },
    sources = cmp.config.sources({
        { name = 'path', group_index = 1, },
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'copilot', group_index = 1 },
        { name = 'luasnip', group_index = 3, keyword_length = 3 },
    }, {
        { name = 'buffer' },
    })
})